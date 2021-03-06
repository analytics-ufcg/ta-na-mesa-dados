library(tidyverse)
library(magrittr)
library(futile.logger)

help <- "
Usage:
Rscript export_alertas_bd.R <anos> <filtro>
<anos> pode ser um ano (2017) ou múltiplos anos separados por vírgula (2017,2018,2019)
<filtro> pode ser merenda ou covid
Exemplos:
Rscript export_alertas_bd.R 2019 merenda
Rscript export_alertas_bd.R 2018,2019,2020 merenda
Certifique-se que os dados do TCE para os anos correspondentes foram baixados (Leia o README)
"

args <- commandArgs(trailingOnly = TRUE)
min_num_args <- 2
if (length(args) < min_num_args) {
  stop(paste("Wrong number of arguments!", help, sep = "\n"))
}

anos <- unlist(strsplit(args[1], split=","))
# anos = c(2018, 2019, 2020, 2021)
filtro <- args[2]
# filtro <- "merenda"

source(here::here("transformer/utils/utils.R"))
source(here::here("transformer/utils/read_utils.R"))
source(here::here("transformer/utils/constants.R"))
source(here::here("transformer/processor/geral/alertas/processa_alertas_data.R"))

flog.info("Criando alertas...")

tipos_alerta <- create_tipo_alertas()

alertas_data <- processa_alertas_data_abertura_contrato(anos)
alertas_cnae_atipico_item <- processa_alertas_cnaes_atipicos_itens(filtro)

alertas <- bind_rows(alertas_data, alertas_cnae_atipico_item)

alertas_bd <- alertas %>% 
  generate_hash_id(c("id_tipo", "nr_documento", "id_contrato"), ALERTA_ID) %>% 
  dplyr::select(id_alerta, dplyr::everything())

flog.info("Escrevendo dados em csv...")
readr::write_csv(tipos_alerta, here::here("data/bd/tipo_alerta.csv"))
readr::write_csv(alertas_bd, here::here("data/bd/alerta.csv"))
flog.info("Concluído!")

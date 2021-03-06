import os, sys
import utils
import subprocess

if __name__ == "__main__":
    # Argumentos que o programa deve receber:
    # -1º: Ano que desejar baixar dos empenhos
    if len(sys.argv) != 2:
        utils.print_usage("fetch_empenhos.py")
        exit(1)

    year = str(sys.argv[1])
    output_path = './data/tce_rs'

    url = 'http://dados.tce.rs.gov.br/dados/municipal/empenhos/' + year + '.csv.zip'
    path = output_path + '/empenhos/' + year
    file_name = year + '.csv.zip'
    utils.download_zip(url, file_name)
    utils.unzip_file(file_name, path)
    subprocess.call(['chmod', '-R', '0777', output_path + '/empenhos/'])
    os.remove(file_name)
    
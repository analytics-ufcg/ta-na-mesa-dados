DROP TABLE IF EXISTS item_contrato;

CREATE TABLE IF NOT EXISTS "item_contrato" (
    "id_item_contrato" VARCHAR(32),
    "id_contrato" VARCHAR(32),
    "id_orgao" INTEGER,
    "id_licitacao" VARCHAR(32),
    "id_item_licitacao" VARCHAR(32),
    "nr_lote" INTEGER,
    "nr_licitacao" BIGINT,
    "ano_licitacao" INTEGER,
    "cd_tipo_modalidade" VARCHAR(3),
    "nr_contrato" BIGINT,
    "ano_contrato" INTEGER,
    "tp_instrumento_contrato" VARCHAR(5),
    "nr_item" INTEGER,
    "qt_itens_contrato" REAL,
    "vl_item_contrato" REAL,
    "vl_total_item_contrato" REAL,
    "dt_inicio_vigencia" DATE,
    "ds_item" VARCHAR(2000),
    "categoria" INTEGER,
    "language" VARCHAR(15),
    "ds_1" VARCHAR(50),
    "ds_2" VARCHAR(100),
    "ds_3" VARCHAR(150),
    PRIMARY KEY ("id_item_contrato"),
    CONSTRAINT item_contrato_key UNIQUE (id_orgao, ano_licitacao, nr_licitacao, cd_tipo_modalidade, nr_contrato, ano_contrato, 
    tp_instrumento_contrato, nr_lote, nr_item),
    FOREIGN KEY ("id_contrato") REFERENCES contrato("id_contrato") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("id_orgao") REFERENCES orgao("id_orgao") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("id_licitacao") REFERENCES licitacao("id_licitacao") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("id_item_licitacao") REFERENCES item("id_item") ON DELETE CASCADE ON UPDATE CASCADE
);
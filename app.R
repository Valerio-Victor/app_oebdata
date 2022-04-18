#---------------------------------------------------------------------------------------------------
#-------------------------------------------PACOTES-------------------------------------------------
#---------------------------------------------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(plotly)
library(reactable)
library(rmarkdown)
library(magrittr, include.only = '%>%')
library(rlang)
library(htmltools)


#---------------------------------------------------------------------------------------------------
#-----------------------------------ARQUIVOS TEMPORÁRIOS--------------------------------------------
#---------------------------------------------------------------------------------------------------
url_total = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/resultados_total.rds'
url_nivel_atividade = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/resultados_nivel_atividade.rds'
url_setor_externo = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/resultados_setor_externo.rds'
url_inflacao = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/resultados_inflacao.rds'

temporario_total = tempfile()
temporario_nivel_atividade = tempfile()
temporario_setor_externo = tempfile()
temporario_inflacao = tempfile()

download.file(url_total, destfile = temporario_total)
download.file(url_nivel_atividade, destfile = temporario_nivel_atividade)
download.file(url_setor_externo, destfile = temporario_setor_externo)
download.file(url_inflacao, destfile = temporario_inflacao)
#---------------------------------------------------------------------------------------------------
#--------------------------------------------UI-----------------------------------------------------
#---------------------------------------------------------------------------------------------------
ui <- dashboardPage(

title = 'OEB-Data', skin = 'blue',

dashboardHeader(titleWidth = 280, title = span(tagList(icon('sitemap'), '  OEB-Data'))),

dashboardSidebar(width = 280,

#---------------------------------------------------------------------------------------------------
#---------------------------------------MENU DO APP-------------------------------------------------
#---------------------------------------------------------------------------------------------------
sidebarMenu(
menuItem('', tabName = 'quemsomos'),
menuItem('CONJUNTURA ECONÔMICA', tabName = 'macro', icon = icon('chart-area'),
menuSubItem('Relatório de Conjuntura',
              tabName = 'conjuntura_total',
              icon = icon('file-alt')
),
menuSubItem('Caderno de Nível de Atividade',
tabName = 'nivel_atividade',
icon = icon('file-alt')
),
menuSubItem('Caderno de Inflação',
            tabName = 'taxa_inflacao',
            icon = icon('file-alt')
),
menuSubItem('Caderno de Setor Externo',
            tabName = 'setor_externo',
            icon = icon('file-alt')
)
),

hr(),

div(style = 'text-align:center', 'Versão 3.0.1')

)

),

#---------------------------------------------------------------------------------------------------
#---------------------------------------CORPO DO APP------------------------------------------------
#---------------------------------------------------------------------------------------------------
dashboardBody(

tabItems(

tabItem(tabName = 'quemsomos',

fluidRow(
column(width = 1),
column(width = 11,
tags$img(src = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/capa_app.png',
         width = '960px', height = '540px')
)
)


),


#---------------------------------------------------------------------------------------------------
#-------------------------------------CONJUNTURA TOTAL----------------------------------------------
#---------------------------------------------------------------------------------------------------
tabItem(tabName = 'conjuntura_total',


fluidRow(
column(width = 8,
box(
title = strong('PARTE I - INSERIR DADOS DO ANALISTA'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, textInput(inputId = 'nome_responsavel_total',
                             label = h4('Analista Responsável:'),
                             value = 'Insira o seu nome...')
)
),
fluidRow(
column(width = 12, textInput(inputId = 'inst_responsavel_total',
                             label = h4('Instituição do Analista:'),
                             value = 'Insira o nome de sua instituição...')
)
)
)
),
column(width = 4,
fluidRow(
box(
title = strong('PARTE II - INICIAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, actionButton(inputId = 'iniciar_total',
                                label = 'Importar os Dados')
)
),
br()
)
),
fluidRow(
box(
title = strong('PARTE III - EXPORTAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, downloadButton(outputId = 'exportar_total',
                                  label = 'Exportar Relatório')
)
),
br()
)
)
)
),

div(style = 'text-align: center; color: #3c8dbc',
    h1('PRODUTO INTERNO BRUTO')),

fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_indice_total'))
),
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_var_pib_indice_total'))
)
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_vc_total',
                                  height = '763px')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE SOBRE O PRODUTO INTERNO BRUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_pib_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
),
fluidRow(
column(width = 6, plotly::plotlyOutput(outputId = 'grafico_real_potencial_total')),
column(width = 6, plotly::plotlyOutput(outputId = 'grafico_hiato_total'))
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE SOBRE O HIATO DO PRODUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_pib_hiato_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DO PRODUTO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_setores_indice_total'))
),
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_setores_vc_total',
                                  height = '763px') ######################################################## Corrigir Tamanho
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE PELA ÓTICA DO PRODUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_otica_produto_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DA DEMANDA')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_demanda_indice_total'))
),
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_demanda_vc_total',
                                  height = '763px') ######################################################## Corrigir Tamanho
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE PELA ÓTICA DA DEMANDA:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_otica_demanda_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ANÁLISE DO NÍVEL DE ATIVIDADE')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_ibc_br_total')),
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pim_sa_indice_total')),
)
),
column(width = 6,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pmc_sa_indice_total')),
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pms_sa_indice_total')),
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DO NÍVEL DE ATIVIDADE:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_nivel_atividade_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA - ÍNDICE CHEIO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_indice_total')
)
),
fluidRow(
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_mensal_total')
),
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_acum_ano_total')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DOS INDICADORES DA INFLAÇÃO CHEIA:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_cheia_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA (POR GRUPOS DE ITENS)')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_peso_grupo_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_difusao_total')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_mensal_grupo_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_acum_ano_grupo_total')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA INFLAÇÃO (POR GRUPOS DE ITENS):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_grupos_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA (POR TIPOS DE ITENS)')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_livres_monitorados_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_livres_monitorados_acum_total')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_comercializaveis_nao_comercializaveis_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_comercializaveis_nao_comercializaveis_acum_total')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA INFLAÇÃO (POR TIPOS DE ITENS):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_itens_inflacao_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('TAXA DE CÂMBIO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_nominal_dolar_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_var_nominal_dolar_total')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_real_dolar_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_var_real_dolar_total')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA TAXA DE CÂMBIO (REAL/DÓLAR):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_dolar_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_nominal_euro_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_var_nominal_euro_total')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_real_euro_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_var_real_euro_total')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA TAXA DE CÂMBIO (REAL/EURO):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_euro_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('BALANÇO DE PAGAMENTOS')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_saldo_tc_total')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_saldo_cf_total')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DO BALANÇO DE PAGAMENTOS:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_bp_total',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('INDICADORES DE SETOR EXTERNO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_r_i_total')
)
),
fluidRow(
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_tc_pib_total')
),
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_id_pib_total')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DOS INDICADORES DE SETOR EXTERNO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_indicadores_bp_total',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
)

), # Fim do Tabitem Conjuntura Total


#---------------------------------------------------------------------------------------------------
#---------------------------------------NÍVEL DE ATIVIDADE------------------------------------------
#---------------------------------------------------------------------------------------------------
tabItem(tabName = 'nivel_atividade',


fluidRow(
column(width = 8,
box(
title = strong('PARTE I - INSERIR DADOS DO ANALISTA'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, textInput(inputId = 'nome_responsavel_nivel_atividade',
                             label = h4('Analista Responsável:'),
                             value = 'Insira o seu nome...')
)
),
fluidRow(
column(width = 12, textInput(inputId = 'inst_responsavel_nivel_atividade',
                             label = h4('Instituição do Analista:'),
                             value = 'Insira o nome de sua instituição...')
)
)
)
),
column(width = 4,
fluidRow(
box(
title = strong('PARTE II - INICIAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, actionButton(inputId = 'iniciar_nivel_atividade',
                                label = 'Importar os Dados')
)
),
br()
)
),
fluidRow(
box(
title = strong('PARTE III - EXPORTAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, downloadButton(outputId = 'exportar_nivel_atividade',
label = 'Exportar Relatório')
)
),
br()
)
)
)
),

div(style = 'text-align: center; color: #3c8dbc',
h1('PRODUTO INTERNO BRUTO')),

fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_indice_nivel_atividade'))
),
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_var_pib_indice_nivel_atividade'))
)
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_vc_nivel_atividade',
                                    height = '763px')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE SOBRE O PRODUTO INTERNO BRUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_pib_nivel_atividade',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
),
fluidRow(
column(width = 6, plotly::plotlyOutput(outputId = 'grafico_real_potencial_nivel_atividade')),
column(width = 6, plotly::plotlyOutput(outputId = 'grafico_hiato_nivel_atividade'))
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE SOBRE O HIATO DO PRODUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_pib_hiato_nivel_atividade',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DO PRODUTO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_setores_indice_nivel_atividade'))
),
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_setores_vc_nivel_atividade',
                                  height = '763px') ######################################################## Corrigir Tamanho
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE PELA ÓTICA DO PRODUTO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_otica_produto_nivel_atividade',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DA DEMANDA')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 7,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pib_demanda_indice_nivel_atividade'))
),
),
column(width = 5,
       reactable::reactableOutput(outputId = 'tabela_pib_demanda_vc_nivel_atividade',
                                  height = '763px') ######################################################## Corrigir Tamanho
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE PELA ÓTICA DA DEMANDA:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_otica_demanda_nivel_atividade',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ANÁLISE DO NÍVEL DE ATIVIDADE')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_ibc_br_nivel_atividade')),
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pim_sa_indice_nivel_atividade')),
)
),
column(width = 6,
fluidRow(
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pmc_sa_indice_nivel_atividade')),
column(width = 12, plotly::plotlyOutput(outputId = 'grafico_pms_sa_indice_nivel_atividade')),
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DO NÍVEL DE ATIVIDADE:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_nivel_atividade_nivel_atividade',
                                 label = '',
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
)


), # Fim do Tabitem Nível de Atividade


#---------------------------------------------------------------------------------------------------
#---------------------------------------TAXA DE INFLAÇÃO--------------------------------------------
#---------------------------------------------------------------------------------------------------
tabItem(tabName = 'taxa_inflacao',


fluidRow(
column(width = 8,
box(
title = strong('PARTE I - INSERIR DADOS DO ANALISTA'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, textInput(inputId = 'nome_responsavel_taxa_inflacao',
                             label = h4('Analista Responsável:'),
                             value = 'Insira o seu nome...')
)
),
fluidRow(
column(width = 12, textInput(inputId = 'inst_responsavel_taxa_inflacao',
                             label = h4('Instituição do Analista:'),
                             value = 'Insira o nome de sua instituição...')
)
)
)
),
column(width = 4,
fluidRow(
box(
title = strong('PARTE II - INICIAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, actionButton(inputId = 'iniciar_taxa_inflacao',
                                label = 'Importar os dados')
)
),
br()
)
),
fluidRow(
box(
title = strong('PARTE III - EXPORTAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, downloadButton(outputId = 'exportar_taxa_inflacao',
                                    label = 'Exportar Relatório')
)
),
br()
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA - ÍNDICE CHEIO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_indice_taxa_inflacao')
)
),
fluidRow(
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_mensal_taxa_inflacao')
),
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_acum_ano_taxa_inflacao')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DOS INDICADORES DA INFLAÇÃO CHEIA:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_cheia_taxa_inflacao',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA (POR GRUPOS DE ITENS)')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_peso_grupo_taxa_inflacao')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_difusao_taxa_inflacao')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_mensal_grupo_taxa_inflacao')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_ipca_var_acum_ano_grupo_taxa_inflacao')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA INFLAÇÃO (POR GRUPOS DE ITENS):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_grupos_taxa_inflacao',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('IPCA (POR TIPOS DE ITENS)')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_livres_monitorados_taxa_inflacao')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_livres_monitorados_acum_taxa_inflacao')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_comercializaveis_nao_comercializaveis_taxa_inflacao')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_comercializaveis_nao_comercializaveis_acum_taxa_inflacao')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA INFLAÇÃO (POR TIPOS DE ITENS):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_inflacao_itens_inflacao_taxa_inflacao',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
)


), # Fim do Tabitem Setor Externo

#---------------------------------------------------------------------------------------------------
#------------------------------------------SETOR EXTERNO--------------------------------------------
#---------------------------------------------------------------------------------------------------
tabItem(tabName = 'setor_externo',

fluidRow(
column(width = 8,
box(
title = strong('PARTE I - INSERIR DADOS DO ANALISTA'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, textInput(inputId = 'nome_responsavel_setor_externo',
                             label = h4('Analista Responsável:'),
                             value = 'Insira o seu nome...')
)
),
fluidRow(
column(width = 12, textInput(inputId = 'inst_responsavel_setor_externo',
                             label = h4('Instituição do Analista:'),
                             value = 'Insira o nome de sua instituição...')
)
)
)
),
column(width = 4,
fluidRow(
box(
title = strong('PARTE II - INICIAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, actionButton(inputId = 'iniciar_setor_externo',
                                label = 'Importar os dados')
)
),
br()
)
),
fluidRow(
box(
title = strong('PARTE III - EXPORTAR ANÁLISE DOS DADOS'),
width = 12,
status = 'primary',
background = 'light-blue',
solidHeader = FALSE,
collapsible = FALSE,
closable = FALSE,
fluidRow(
column(width = 12, downloadButton(outputId = 'exportar_setor_externo',
                                  label = 'Exportar Relatório')
)
),
br()
)
)
)
),

div(style = 'text-align: center; color: #3c8dbc',
            h1('TAXA DE CÂMBIO')),

fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
       plotly::plotlyOutput(outputId = 'grafico_nominal_dolar_setor_externo')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
       plotly::plotlyOutput(outputId = 'grafico_var_nominal_dolar_setor_externo')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
       plotly::plotlyOutput(outputId = 'grafico_real_dolar_setor_externo')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
       plotly::plotlyOutput(outputId = 'grafico_var_real_dolar_setor_externo')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA TAXA DE CÂMBIO (REAL/DÓLAR):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_dolar_setor_externo',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_nominal_euro_setor_externo')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_var_nominal_euro_setor_externo')
)
)
)
),
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_real_euro_setor_externo')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
       plotly::plotlyOutput(outputId = 'grafico_var_real_euro_setor_externo')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DA TAXA DE CÂMBIO (REAL/EURO):',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_euro_setor_externo',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('BALANÇO DE PAGAMENTOS')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_saldo_tc_setor_externo')
)
)
),
column(width = 6,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_saldo_cf_setor_externo')
)
)
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DO BALANÇO DE PAGAMENTOS:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_bp_setor_externo',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('INDICADORES DE SETOR EXTERNO')),


fluidRow(
box(
title = '',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12,
plotly::plotlyOutput(outputId = 'grafico_r_i_setor_externo')
)
),
fluidRow(
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_tc_pib_setor_externo')
),
column(width = 6,
plotly::plotlyOutput(outputId = 'grafico_id_pib_setor_externo')
)
),
fluidRow(
column(width = 12,
box(
title = 'ANÁLISE DOS INDICADORES DE SETOR EXTERNO:',
width = 12,
status = 'primary',
solidHeader = TRUE,
collapsible = FALSE,
collapsed = FALSE,
fluidRow(
column(width = 12, textAreaInput(inputId = 'texto_indicadores_bp_setor_externo',
                                 label = h4(''),
                                 value = 'Insira aqui a sua análise...',
                                 width = '100%',
                                 rows = 5,
                                 resize = 'vertical')
)
)
)
)
)
)
)


) # Fim do Tabitem Setor Externo




































)
)
)



#---------------------------------------------------------------------------------------------------
#------------------------------------------SERVER---------------------------------------------------
#---------------------------------------------------------------------------------------------------
server <- function(input, output, session) {






# Importação dos Dados ---------------------------------------------------------
observeEvent(input$iniciar_setor_externo, {

withProgress(message = 'Iniciando a análise...', value = 0.1, {

Sys.sleep(1)

incProgress(0.9)

incProgress(1, message = 'Importando os dados...')

Sys.sleep(1)

incProgress(7, message = 'Aguarde, mesmo após a barra de progresso desaparecer há processamento de dados!')

Sys.sleep(3)

})

resultados_setor_externo <- readRDS(temporario_setor_externo)

output$grafico_nominal_dolar_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_nominal_dolar']]
)

output$grafico_var_nominal_dolar_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_var_nominal_dolar']]
)

output$grafico_real_dolar_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_real_dolar']]
)

output$grafico_var_real_dolar_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_var_real_dolar']]
)

output$grafico_nominal_euro_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_nominal_euro']]
)

output$grafico_var_nominal_euro_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_var_nominal_euro']]
)

output$grafico_real_euro_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_real_euro']]
)

output$grafico_var_real_euro_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_var_real_euro']]
)

output$grafico_saldo_tc_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_saldo_tc']]
)

output$grafico_tc_pib_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_tc_pib']]
)

output$grafico_saldo_cf_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_saldo_cf']]
)

output$grafico_id_pib_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_id_pib']]
)

output$grafico_r_i_setor_externo <- plotly::renderPlotly(
  resultados_setor_externo[['grafico_r_i']]
)

})

# nome <- reactive(input$nome_responsavel)
#
# instituicao <- reactive(input$inst_responsavel)
#
# pib_texto <- reactive(input$texto_pib)
#
# texto_pib_hiato <- reactive(input$texto_pib_hiato)
#
# otica_produto_texto <- reactive(input$texto_otica_produto)
#
# otica_demanda_texto <- reactive(input$texto_otica_demanda)
#
output$exportar_total <- downloadHandler(
  filename = 'relatorio_conjuntura_oeb.html',
  content = function(file) {
   rmarkdown::render(
     input = 'www/template_conjuntura.Rmd',
     output_file = file
   )
  }
)
#
#
# # Importação dos Dados ---------------------------------------------------------
# observeEvent(input$iniciar, {
#
#
#
#   withProgress(message = 'Iniciando a análise...', value = 0.1, {
#
#     Sys.sleep(1)
#
#     incProgress(0.9)
#
#     incProgress(1, message = 'Importando os dados...')
#
#     Sys.sleep(1)
#
#     incProgress(7, message = 'Aguarde, mesmo após a barra de progresso desaparecer há processamento de dados!')
#
#     Sys.sleep(3)
#
#   })
#
#   resultados <- readRDS(temporario)
#
#   output$grafico_pib_indice <- plotly::renderPlotly(
#     resultados[['grafico_pib_indice']]
#   )
#
#   output$grafico_var_pib_indice <- plotly::renderPlotly(
#     resultados[['grafico_var_pib_indice']]
#   )
#
#   output$tabela_pib_vc <- reactable::renderReactable(
#     resultados[['tabela_pib_vc']]
#   )
#
#   output$grafico_real_potencial <- plotly::renderPlotly(
#     resultados[['grafico_real_potencial']]
#   )
#
#   output$grafico_hiato <- plotly::renderPlotly(
#     resultados[['grafico_hiato']]
#   )
#
#   output$grafico_pib_setores_indice <- plotly::renderPlotly(
#     resultados[['grafico_pib_setores_indice']]
#   )
#
#   output$grafico_var_pib_setores_indice <- plotly::renderPlotly(
#     resultados[['grafico_var_pib_setores_indice']]
#   )
#
#   output$tabela_pib_setores_vc <- reactable::renderReactable(
#     resultados[['tabela_pib_setores_vc']]
#   )
#
#   output$grafico_pib_demanda_indice <- plotly::renderPlotly(
#     resultados[['grafico_pib_demanda_indice']]
#   )
#
#   output$grafico_var_pib_demanda_indice <- plotly::renderPlotly(
#     resultados[['grafico_var_pib_demanda_indice']]
#   )
#
#   output$tabela_pib_demanda_vc <- reactable::renderReactable(
#     resultados[['tabela_pib_demanda_vc']]
#   )
#
#   output$grafico_saldo_tc <- plotly::renderPlotly(
#     resultados[['grafico_saldo_tc']]
#   )
#
#   output$grafico_tc_pib <- reactable::renderReactable(
#     resultados[['grafico_tc_pib']]
#   )
#
#   output$grafico_pib_demanda_indice <- plotly::renderPlotly(
#     resultados[['grafico_saldo_cf']]
#   )
#
#   output$grafico_var_pib_demanda_indice <- plotly::renderPlotly(
#     resultados[['grafico_id_pib']]
#   )
#
#   output$tabela_pib_demanda_vc <- reactable::renderReactable(
#     resultados[['grafico_r_i']]
#   )
#
# })






}





shinyApp(ui, server)

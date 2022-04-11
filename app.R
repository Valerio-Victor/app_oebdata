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


url = 'https://github.com/Valerio-Victor/app_oebdata_dev/raw/master/resultados.rds'

temporario = tempfile()

download.file(url, destfile = temporario)
#---------------------------------------------------------------------------------------------------
#--------------------------------------------UI-----------------------------------------------------
#---------------------------------------------------------------------------------------------------
ui <- dashboardPage(

title = 'OEB-Data', skin = 'blue',

dashboardHeader(titleWidth = 280, title = span(tagList(icon('sitemap'), '  OEB Data'))),

dashboardSidebar(width = 280,

#---------------------------------------------------------------------------------------------------
#---------------------------------------TÍTULO DO APP-----------------------------------------------
#---------------------------------------------------------------------------------------------------
sidebarMenu(

menuItem('CONJUNTURA ECONÔMICA', tabName = 'orientacao', icon = icon('area-chart'),
  menuSubItem('Relatório de Conjuntura', tabName = 'conjuntura_total', icon = icon('file-text-o'))
),

hr(),

div(style = 'text-align:center', 'Versão 1.0.0')

)

),

#---------------------------------------------------------------------------------------------------
#---------------------------------------CORPO DO APP------------------------------------------------
#---------------------------------------------------------------------------------------------------
dashboardBody(

tabItems(

# CONJUNTURA ECONÔMICA------------------------------------------------------------------------------
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
           fluidRow(column(width = 12, textInput('nome_responsavel',
                                                 label = h4('Analista Responsável:'),
                                                 value = 'Insira o seu nome...'))),
           fluidRow(column(width = 12, textInput('inst_responsavel',
                                                 label = h4('Instituição do Analista:'),
                                                 value = 'Insira o nome de sua instituição...')))
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
             fluidRow(column(width = 12, actionButton(inputId = 'iniciar', label = 'Importar os Dados'))),
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
             fluidRow(column(width = 12, downloadButton('exportar', label = 'Exportar Relatório'))),
             br()
           )
         )
  )
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('PRODUTO INTERNO BRUTO')),


fluidRow(
  box(title = '',
      width = 12,
      status = 'primary',
      solidHeader = TRUE,
      collapsible = FALSE,
      collapsed = FALSE,
      fluidRow(
        column(width = 7,
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_pib_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_var_pib_indice')))),
        column(width = 5, reactable::reactableOutput('tabela_pib_vc', height = '763px'))
        ),
      fluidRow(column(width = 12,
                      box(title = 'Análise',
                          width = 12,
                          status = 'primary',
                          solidHeader = TRUE,
                          collapsible = FALSE,
                          collapsed = FALSE,
                          fluidRow(column(width = 12, textAreaInput('texto_pib',
                                                                    label = h4(''),
                                                                    value = 'Insira aqui a sua análise...',
                                                                    width = '100%',
                                                                    rows = 5,
                                                                    resize = 'vertical')))))
      ),
      fluidRow(column(width = 6, plotly::plotlyOutput('grafico_real_potencial')),
               column(width = 6, plotly::plotlyOutput('grafico_hiato'))),
      fluidRow(column(width = 12,
                      box(title = 'Análise',
                          width = 12,
                          status = 'primary',
                          solidHeader = TRUE,
                          collapsible = FALSE,
                          collapsed = FALSE,
                          fluidRow(column(width = 12, textAreaInput('texto_pib_hiato',
                                                                    label = h4(''),
                                                                    value = 'Insira aqui a sua análise...',
                                                                    width = '100%',
                                                                    rows = 5,
                                                                    resize = 'vertical')))))
      )
  )
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DO PRODUTO')),


fluidRow(
  box(title = '',
      width = 12,
      status = 'primary',
      solidHeader = TRUE,
      collapsible = FALSE,
      collapsed = FALSE,
      fluidRow(
        column(width = 7,
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_pib_setores_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_var_pib_setores_indice')))),
        column(width = 5, reactable::reactableOutput('tabela_pib_setores_vc', height = '763px'))
      ),
      fluidRow(column(width = 12,
      box(title = 'Análise',
          width = 12,
          status = 'primary',
          solidHeader = TRUE,
          collapsible = FALSE,
          collapsed = FALSE,
          fluidRow(column(width = 12, textAreaInput('texto_otica_produto',
                                                    label = h4(''),
                                                    value = 'Insira aqui a sua análise...',
                                                    width = '100%',
                                                    rows = 5,
                                                    resize = 'vertical')))))
      )
  )
),


div(style = 'text-align: center; color: #3c8dbc',
    h1('ÓTICA DA DEMANDA')),


fluidRow(
  box(title = '',
      width = 12,
      status = 'primary',
      solidHeader = TRUE,
      collapsible = FALSE,
      collapsed = FALSE,
      fluidRow(
        column(width = 7,
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_pib_demanda_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('grafico_var_pib_demanda_indice')))),
        column(width = 5, reactable::reactableOutput('tabela_pib_demanda_vc', height = '763px'))
      ),
      fluidRow(column(width = 12,
      box(title = 'Análise',
          width = 12,
          status = 'primary',
          solidHeader = TRUE,
          collapsible = FALSE,
          collapsed = FALSE,
          fluidRow(column(width = 12, textAreaInput('texto_otica_demanda',
                                                    label = h4(''),
                                                    value = 'Insira aqui a sua análise...',
                                                    width = '100%',
                                                    rows = 5,
                                                    resize = 'vertical')))))
      )
  )
)


)
)
)
)



#---------------------------------------------------------------------------------------------------
#------------------------------------------SERVER---------------------------------------------------
#---------------------------------------------------------------------------------------------------
server <- function(input, output, session) {


# Importação dos Dados ---------------------------------------------------------
observeEvent(input$iniciar, {



withProgress(message = 'Iniciando a análise...', value = 0.1, {

Sys.sleep(1)

incProgress(0.9)

incProgress(1, message = 'Importando os dados...')

Sys.sleep(1)

incProgress(7, message = 'Aguarde, mesmo após a barra de progresso desaparecer há processamento de dados!')

Sys.sleep(3)

})

resultados <- readRDS(temporario)

output$grafico_pib_indice <- plotly::renderPlotly(
  resultados[['grafico_pib_indice']]
)

output$grafico_var_pib_indice <- plotly::renderPlotly(
  resultados[['grafico_var_pib_indice']]
)

output$tabela_pib_vc <- reactable::renderReactable(
  resultados[['tabela_pib_vc']]
)

output$grafico_real_potencial <- plotly::renderPlotly(
  resultados[['grafico_real_potencial']]
)

output$grafico_hiato <- plotly::renderPlotly(
  resultados[['grafico_hiato']]
)

output$grafico_pib_setores_indice <- plotly::renderPlotly(
  resultados[['grafico_pib_setores_indice']]
)

output$grafico_var_pib_setores_indice <- plotly::renderPlotly(
  resultados[['grafico_var_pib_setores_indice']]
)

output$tabela_pib_setores_vc <- reactable::renderReactable(
  resultados[['tabela_pib_setores_vc']]
)

output$grafico_pib_demanda_indice <- plotly::renderPlotly(
  resultados[['grafico_pib_demanda_indice']]
)

output$grafico_var_pib_demanda_indice <- plotly::renderPlotly(
  resultados[['grafico_var_pib_demanda_indice']]
)

output$tabela_pib_demanda_vc <- reactable::renderReactable(
  resultados[['tabela_pib_demanda_vc']]
)

})

nome <- reactive(input$nome_responsavel)

instituicao <- reactive(input$inst_responsavel)

pib_texto <- reactive(input$texto_pib)

texto_pib_hiato <- reactive(input$texto_pib_hiato)

otica_produto_texto <- reactive(input$texto_otica_produto)

otica_demanda_texto <- reactive(input$texto_otica_demanda)

output$exportar <- downloadHandler(
  filename = 'relatorio_conjuntura_oeb.html',
  content = function(file) {
   rmarkdown::render(
     input = 'www/template.Rmd',
     output_file = file,
     params = list(responsavel = nome(),
                   instituicao_do_responsavel = instituicao(),
                   pib_texto = pib_texto(),
                   texto_pib_hiato = texto_pib_hiato(),
                   otica_produto_texto = otica_produto_texto(),
                   otica_demanda_texto = otica_demanda_texto())
   )
  }
)




}





shinyApp(ui, server)

#---------------------------------------------------------------------------------------------------
#-------------------------------------------PACOTES-------------------------------------------------
#---------------------------------------------------------------------------------------------------
library(shiny)


library(shinydashboard)


library(magrittr, include.only = '%>%')


library(rlang)


library(htmltools)


#---------------------------------------------------------------------------------------------------
#-----------------------------------PREPARANDO BARRAS DE PROGRESSO----------------------------------
#---------------------------------------------------------------------------------------------------
aviso_inicial <- tagList(
  waiter::spin_solar(),
  br(),
  h3('GERANDO O RELATÓRIO'),
  br(),
  h4('Isto pode demorar alguns minutos...')
)

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
)

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
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_pib_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_var_pib_indice')))),
        column(width = 5, reactable::reactableOutput('tab_pib_vc', height = '763px'))
        ),
      fluidRow(column(width = 6, plotly::plotlyOutput('graf_real_potencial')),
               column(width = 6, plotly::plotlyOutput('graf_hiato'))),
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
                                                    resize = 'vertical')))
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
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_pib_setores_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_var_pib_setores_indice')))),
        column(width = 5, reactable::reactableOutput('tab_pib_setores_vc', height = '763px'))
      ),
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
                                                    resize = 'vertical')))
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
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_pib_demanda_indice'))),
               fluidRow(column(width = 12, plotly::plotlyOutput('graf_var_pib_demanda_indice')))),
        column(width = 5, reactable::reactableOutput('tab_pib_demanda_vc', height = '763px'))
      ),
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
                                                    resize = 'vertical')))
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

library(magrittr, include.only = '%>%')

resultados <- readRDS('./www/resultados.rds')

output$graf_pib_indice <- plotly::renderPlotly(
  resultados[['graf_pib_indice']]
)

output$graf_var_pib_indice <- plotly::renderPlotly(
  resultados[['graf_var_pib_indice']]
)

output$tab_pib_vc <- reactable::renderReactable(
  resultados[['tab_pib_vc']]
)

output$graf_real_potencial <- plotly::renderPlotly(
  resultados[['graf_real_potencial']]
)

output$graf_hiato <- plotly::renderPlotly(
  resultados[['graf_hiato']]
)

output$graf_pib_setores_indice <- plotly::renderPlotly(
  resultados[['graf_pib_setores_indice']]
)

output$graf_var_pib_setores_indice <- plotly::renderPlotly(
  resultados[['graf_var_pib_setores_indice']]
)

output$tab_pib_setores_vc <- reactable::renderReactable(
  resultados[['tab_pib_setores_vc']]
)

output$graf_pib_demanda_indice <- plotly::renderPlotly(
  resultados[['graf_pib_demanda_indice']]
)

output$graf_var_pib_demanda_indice <- plotly::renderPlotly(
  resultados[['graf_var_pib_demanda_indice']]
)

output$tab_pib_demanda_vc <- reactable::renderReactable(
  resultados[['tab_pib_demanda_vc']]
)

})


nome <- reactive(input$nome_responsavel)

instituicao <- reactive(input$inst_responsavel)

pib_texto <- reactive(input$texto_pib)

otica_produto_texto <- reactive(input$texto_otica_produto)

otica_demanda_texto <- reactive(input$texto_otica_demanda)

output$exportar <- downloadHandler(
  filename = paste0('relatorio_conjuntura_oeb','.html'),
  content = function(file) {
   rmarkdown::render(
     input = 'www/relatorio_conjuntura_oeb.Rmd',
     output_file = file,
     params = list(responsavel = nome(),
                   instituicao_do_responsavel = instituicao(),
                   pib_texto = pib_texto(),
                   otica_produto_texto = otica_produto_texto(),
                   otica_demanda_texto = otica_demanda_texto())
   )
  }
)




}





shinyApp(ui, server)

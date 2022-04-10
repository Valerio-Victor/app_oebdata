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

),

hr(),

div(style = 'text-align:center', 'VERSÃO TRIAL')

),

#---------------------------------------------------------------------------------------------------
#---------------------------------------CORPO DO APP------------------------------------------------
#---------------------------------------------------------------------------------------------------
dashboardBody(

tabItems(

# CONJUNTURA ECONÔMICA------------------------------------------------------------------------------
tabItem(tabName = 'conjuntura_total',
fluidRow(
 box(
  title = strong('DADOS DO ANALISTA'),
  width = 12,
  status = 'primary',
  background = 'light-blue',
  solidHeader = FALSE,
  collapsible = FALSE,
  closable = FALSE,
  waiter::use_waiter(),
  waiter::use_waitress(color = '#3c8dbc'),
  fluidRow(column(width = 6, textInput('nome_responsável', label = h4('Analista Responsável'),
                                        value = 'Insira o seu nome...')),
           column(width = 6, textInput('inst_responsável', label = h4('Instituição'),
                                        value = 'Insira o nome de sua instituição...'))),
  br(),
  fluidRow(column(width = 12, actionButton(inputId = 'iniciar', label = 'Iniciar Análise do Relatório'))),
  br(),
  fluidRow(column(width = 12, actionButton(inputId = 'exportar', label = 'Exportar Análise do Relatório')))
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
               column(width = 6, plotly::plotlyOutput('graf_hiato'))))),


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
      )
      )),


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
      )
  ))


)
)
)
)



#---------------------------------------------------------------------------------------------------
#------------------------------------------SERVER---------------------------------------------------
#---------------------------------------------------------------------------------------------------
server <- function(input, output, session) {


#---------------------------------------------------------------------------------------------------
#-----------------------------Seção de Análise do Nível de Atividade--------------------------------
#---------------------------------------------------------------------------------------------------





# Importação dos Dados e Tratamentos Comuns---------------------------------------------------------
observeEvent(input$iniciar, {

library(magrittr, include.only = '%>%')

resultados <- readRDS('resultados.rds')

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
}





shinyApp(ui, server)

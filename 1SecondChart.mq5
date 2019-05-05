//+------------------------------------------------------------------+
//|                                                 1SecondChart.mq5 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"
#property indicator_separate_window
#property  indicator_buffers 2
#property indicator_plots    2
#property indicator_type1   DRAW_LINE 
#property indicator_type2   DRAW_LINE 
#property  indicator_color1  clrGoldenrod
#property indicator_style1 STYLE_SOLID 
#property indicator_style2 STYLE_SOLID 
#property  indicator_color2  clrGray
//#property  indicator_width1  1
//#property  indicator_width2  1

//--- input parameters
input int Shift = 300;

double BufAsk[];
double BufBid[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit() {
//--- indicator buffers mapping
    EventSetTimer(1);
    
    ArrayResize(BufAsk, Shift);
    ArrayResize(BufBid, Shift);
    ArrayInitialize(BufAsk, 0.0);
    ArrayInitialize(BufBid, 0.0);
    
//--- indicator buffers mapping

    
    SetIndexBuffer(0, BufAsk, INDICATOR_DATA);
    ArraySetAsSeries(BufAsk, true); 
    SetIndexBuffer(1, BufBid, INDICATOR_DATA);
    ArraySetAsSeries(BufBid, true); 
    
    // SetIndexStyle(0, DRAW_LINE);
    PlotIndexSetInteger(0, PLOT_LINE_WIDTH, 1);
    
    // SetIndexStyle(1, DRAW_LINE);
    PlotIndexSetInteger(1, PLOT_LINE_WIDTH, 1);

    // SetIndexLabel(0, "Ask");
    PlotIndexSetString(0, PLOT_LABEL, "Ask");
    
    // SetIndexLabel(1, "Bid");
    PlotIndexSetString(1, PLOT_LABEL, "Bid");
    
    // IndicatorShortName("1SecondChart");
    IndicatorSetString(INDICATOR_SHORTNAME, "1SecondChart");
//---
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
//---
   
//--- return value of prev_calculated for next call
    return(rates_total);
}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer() {
//---
    Comment(TimeToString(TimeLocal(), TIME_DATE | TIME_MINUTES | TIME_SECONDS));

    int i;
    
    for(i = Shift; i >= 0; i--){
        BufAsk[i + 1] = BufAsk[i];
        BufBid[i + 1] = BufBid[i];
    }
    
    BufAsk[0] = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    BufBid[0] = SymbolInfoDouble(Symbol(), SYMBOL_BID);
}
//+------------------------------------------------------------------+

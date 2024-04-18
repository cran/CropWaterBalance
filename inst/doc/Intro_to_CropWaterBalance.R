## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(CropWaterBalance)

## ----CpsET0PM-----------------------------------------------------------------
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Rn <- DataForCWB[, 6]
WS <- DataForCWB[, 7]
RH <- DataForCWB[, 8]
G <- DataForCWB[, 9]
CpsET0PM <-
  ET0_PM(
    Tavg = Tavg,
    Tmax = Tmax,
    Tmin = Tmin,
    Rn = Rn,
    RH = RH,
    WS = WS,
    G = G,
    Alt = 700
  )
head(CpsET0PM)

## ----CpsET0PM estimating G----------------------------------------------------
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Rn <- DataForCWB[, 6]
WS <- DataForCWB[, 7]
RH <- DataForCWB[, 8]
G <- Soil_Heat_Flux(Tavg)
CpsET0PM_WithG <-
  ET0_PM(
    Tavg = Tavg,
    Tmax = Tmax,
    Tmin = Tmin,
    Rn = Rn,
    RH = RH,
    WS = WS,
    G = G,
    Alt = 700
  )
CpsET0PM_WithoutG <-
  ET0_PM(
    Tavg = Tavg,
    Tmax = Tmax,
    Tmin = Tmin,
    Rn = Rn,
    RH = RH,
    WS = WS,
    Alt = 700
  )
head(cbind(CpsET0PM_WithG, CpsET0PM_WithoutG))

## ----CpsET0PT and CpsET0HS----------------------------------------------------
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Ra <- DataForCWB[, 5]
Rn <- DataForCWB[, 6]
G <- DataForCWB[, 9]
CpsET0PT <- ET0_PT(Tavg = Tavg, Rn = Rn, G = G)
CpsET0HS <- ET0_HS(
  Ra = Ra,
  Tavg = Tavg,
  Tmax = Tmax,
  Tmin = Tmin
)
head(cbind(CpsET0PT, CpsET0HS))

## ----Evaluating alternative methods for ETO-----------------------------------
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Ra <- DataForCWB[, 5]
Rn <- DataForCWB[, 6]
WS <- DataForCWB[, 7]
RH <- DataForCWB[, 8]
G <- DataForCWB[, 9]
CpsET0PM <-
  ET0_PM(
    Tavg = Tavg,
    Tmax = Tmax,
    Tmin = Tmin,
    Rn = Rn,
    RH = RH,
    WS = WS,
    G = G,
    Alt = 700
  )
CpsET0PT <- ET0_PT(Tavg = Tavg, Rn = Rn, G = G)
CpsET0HS <- ET0_HS(
  Ra = Ra,
  Tavg = Tavg,
  Tmax = Tmax,
  Tmin = Tmin
)
PM_PT <- Compare(Sample1 = CpsET0PM, Sample2 = CpsET0PT)
PM_PT
Descrp_PM_PT <-
  cbind(Descriptive(Sample = CpsET0PM), Descriptive(Sample = CpsET0PT))
Descrp_PM_PT
PM_HS <- Compare(Sample1 = CpsET0PM, Sample2 = CpsET0HS)
PM_HS
Descrp_PM_HS <-
  cbind(Descriptive(Sample = CpsET0PM), Descriptive(Sample = CpsET0HS))
Descrp_PM_HS

## ----`CWB()` and `DInitial()` in Campinas-SP, Brazil: scenario 1--------------
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Rn <- DataForCWB[, 6]
WS <- DataForCWB[, 7]
RH <- DataForCWB[, 8]
G <- DataForCWB[, 9]
ET0 <- ET0_PM(Tavg, Tmax, Tmin, Rn, RH, WS, G, Alt = 700)
Dinitial <-
  Dinitial(teta_FC = 0.30,
           teta_Obs = 0.17,
           Drz = DataForCWB[1, 11])
Rain <- DataForCWB[, 10]
Drz <- DataForCWB[, 11]
AWC <- DataForCWB[, 12]
MAD <- DataForCWB[, 13]
Kc <- DataForCWB[, 14]
Irrig <- DataForCWB[, 15]
Scenario1 <- CWB(
  Rain = Rain,
  ET0 = ET0,
  AWC = AWC,
  Drz = Drz,
  Kc = Kc,
  Irrig = Irrig,
  MAD = MAD,
  InitialD = Dinitial,
  start.date = "2011-11-23"
)
Scenario1[1:8, ]
Irrig[7] <- 16
Scenario2 <- CWB(
  Rain = Rain,
  ET0 = ET0,
  AWC = AWC,
  Drz = Drz,
  Kc = Kc,
  Irrig = Irrig,
  MAD = MAD,
  InitialD = Dinitial,
  start.date = "2011-11-23"
)
Scenario2[1:8, ]

## ----`CWB_fixedSchedule()` and `DInitial()` in Campinas-SP, Brazil: scenario 1----
Tavg <- DataForCWB[, 2]
Tmax <- DataForCWB[, 3]
Tmin <- DataForCWB[, 4]
Rn <- DataForCWB[, 6]
WS <- DataForCWB[, 7]
RH <- DataForCWB[, 8]
G <- DataForCWB[, 9]
ET0 <- ET0_PM(Tavg, Tmax, Tmin, Rn, RH, WS, G, Alt = 700)
Dinitial <-
  Dinitial(teta_FC = 0.30,
           teta_Obs = 0.17,
           Drz = DataForCWB[1, 11])
Rain <- DataForCWB[, 10]
Drz <- DataForCWB[, 11]
AWC <- DataForCWB[, 12]
MAD <- DataForCWB[, 13]
Kc <- DataForCWB[, 14]
Scheduling <- 5
Irrig <- DataForCWB[, 15]
Scenario_FixedSchedule <-
  CWB_FixedSchedule(
    Rain = Rain,
    ET0 = ET0,
    AWC = AWC,
    Drz = Drz,
    Kc = Kc,
    Irrig = Irrig,
    MAD = MAD,
    InitialD = Dinitial,
    Scheduling = Scheduling,
    start.date = "2011-11-23"
  )
Scenario_FixedSchedule[1:15, ]


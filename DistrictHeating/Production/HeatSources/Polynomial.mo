within DistrictHeating.Production.HeatSources;
model Polynomial "Heat source based on a polynomial function"
  //Extensions
  extends DistrictHeating.Production.BaseClasses.PartialHeatSource;

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter Real beta[:] "Constant parameters of the polynomial function";
  parameter Integer powers[:,:] "Constant powers of the polynomial function";

  final parameter Integer n = size(powers, 1);
  final parameter Integer k = size(powers, 2);

  //Components
   Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=modulationMin,
    uHigh=modulationStart)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

equation
  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 1.0 else 0.0;
  hysteresis.u = modulationInit;
  modulationInit = QAsked/QMax*100;
  modulation = if hysteresis.y then min(modulationInit, 100) else 0;

  //Calcualation of the heat powers
  QMax = PolynomialDimensions(beta=beta, powers=powers, X={100, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k)/etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation) > 0 then UALoss*(heatPort.T - sim.Te) else 0;

  //Polynomial
  eta = PolynomialDimensions(beta=beta, powers=powers, X={modulation, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k);
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  annotation (Diagram(graphics));
end Polynomial;

within DistrictHeating.HeatingSystems;
model HeatExchangerM "Heating system with a massflow substation control"

  //Extensions
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
    isDH=true,
    nEmbPorts=0);

  //Parameters
  parameter Modelica.SIunits.Power[nZones] QNom=2000*ones(nZones)
    "Nominal heating power of each zone";
  parameter Modelica.SIunits.Temperature TSupply=273.15+70
    "Radiator supply temperature";
  parameter Modelica.SIunits.Temperature TReturn=273.15+60
    "Radiator return temeprature";
  parameter Modelica.SIunits.Temperature TBoiler=273.15+80
    "Radiator return temeprature";
  parameter Real KVs[nZones] = ones(nZones)*10
    "Values for the balancing valves";

  final parameter Modelica.SIunits.MassFlowRate[nZones] m_flow_nominal = QNom/(4180.6*(TSupply-TReturn))
    "Nominal mass flow rates";

  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad[nZones](
    redeclare package Medium = Medium,
    Q_flow_nominal=QNom,
    T_a_nominal=TSupply,
    T_b_nominal=TReturn)
    annotation (Placement(transformation(extent={{-32,-46},{-52,-26}})));
  IDEAS.Fluid.BaseCircuits.HeatExchanger heatExchanger(
    m_flow_nominal=sum(m_flow_nominal),
    redeclare package Medium = Medium,
    measureReturnT=false,
    efficiency=0.8,
    dp=0,
    dp1_nominal=0,
    dp2_nominal=0)                                 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={64,-42})));
  IDEAS.Fluid.BaseCircuits.ParallelPipesSplitter parallelPipesSplitter(n=nZones,
    redeclare package Medium = Medium,
    m_flow_nominal=sum(m_flow_nominal),
    V=0.01)
    annotation (Placement(transformation(extent={{42,-52},{22,-32}})));
  IDEAS.Fluid.BaseCircuits.PumpSupply_m_flow pumpSupply_m_flow[nZones](
    KvReturn=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    includePipes=false,
    dp=200)
    annotation (Placement(transformation(extent={{10,-52},{-10,-32}})));
  IDEAS.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{16,-84},{36,-64}})));
  Control.Hysteresis hysteresis[nZones](
    realFalse=m_flow_nominal,
    release=false,
    uHigh=273.15 + 21,
    realTrue=0,
    uLow=273.15 + 20)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  IDEAS.Fluid.BaseCircuits.PumpSupply_m_flow
                                          flowController(
      redeclare package Medium = Medium,
    m_flow_nominal=sum(m_flow_nominal),
    KvReturn=5,
    includePipes=true,
    useBalancingValve=false,
    addPowerToMedium=true,
    dp=0)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={102,-42})));
equation
  QHeaSys = 0;
  P[1] = 0;
  Q[1] = 0;

  connect(heatExchanger.port_b1, parallelPipesSplitter.port_a) annotation (Line(
      points={{54,-36},{42,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_b, heatExchanger.port_a2) annotation (Line(
      points={{42,-48},{54,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_aN, pumpSupply_m_flow.port_b2) annotation (
     Line(
      points={{22,-48},{10,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_bN, pumpSupply_m_flow.port_a1) annotation (
     Line(
      points={{22,-36},{10,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpSupply_m_flow.port_b1, rad.port_a) annotation (Line(
      points={{-10,-36},{-32,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rad.port_b, pumpSupply_m_flow.port_a2) annotation (Line(
      points={{-52,-36},{-60,-36},{-60,-48},{-10,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], parallelPipesSplitter.port_a) annotation (Line(
      points={{36,-74},{48,-74},{48,-36},{42,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPortCon, rad.heatPortCon) annotation (Line(
      points={{-200,20},{-40,20},{-40,-28.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPortRad, rad.heatPortRad) annotation (Line(
      points={{-200,-20},{-44,-20},{-44,-28.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(flowPort_supply, flowPort_supply) annotation (Line(
      points={{160,-100},{160,-96},{160,-96},{160,-100}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(TSensor, hysteresis.u) annotation (Line(
      points={{-204,-60},{-120,-60},{-120,40},{-81.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis.y, pumpSupply_m_flow.u) annotation (Line(
      points={{-59.2,40},{0,40},{0,-31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowController.port_b1, heatExchanger.port_a1) annotation (Line(
      points={{92,-36},{74,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b2, flowController.port_a2) annotation (Line(
      points={{74,-48},{92,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowController.port_b2, flowPort_return) annotation (Line(
      points={{112,-48},{120,-48},{120,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowController.port_a1, flowPort_supply) annotation (Line(
      points={{112,-36},{160,-36},{160,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.massFlow2, flowController.u) annotation (Line(
      points={{59.2,-31.4},{59.2,-14},{102,-14},{102,-31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end HeatExchangerM;

within DistrictHeating.HeatingSystems;
model HeatExchangerdp "Heating system with a dp substation control"

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
    dp1_nominal=200,
    dp2_nominal=200,
    redeclare package Medium = Medium,
    measureReturnT=false,
    dp=200,
    efficiency=0.8)                                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={64,-42})));
  IDEAS.Fluid.BaseCircuits.FlowController flowController(
      redeclare package Medium = Medium,
    CvDataSupply=IDEAS.Fluid.Types.CvTypes.Kv,
    m_flow_nominal=sum(m_flow_nominal),
    dpValve_nominalSupply=0,
    KvReturn=5,
    KvSupply=1,
    includePipes=true,
    measureSupplyT=false,
    measureReturnT=false,
    dp=200,
    useBalancingValve=true)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={106,-42})));
  IDEAS.Fluid.BaseCircuits.ParallelPipesSplitter parallelPipesSplitter(n=nZones,
    redeclare package Medium = Medium,
    m_flow_nominal=sum(m_flow_nominal),
    V=0.01)
    annotation (Placement(transformation(extent={{30,-52},{10,-32}})));
  IDEAS.Fluid.BaseCircuits.PumpSupply_m_flow pumpSupply_m_flow[nZones](
    KvReturn=5,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    includePipes=false,
    dp=200)
    annotation (Placement(transformation(extent={{0,-52},{-20,-32}})));
  IDEAS.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{16,-84},{36,-64}})));
  Control.Hysteresis hysteresis[nZones](
    realFalse=m_flow_nominal,
    release=false,
    uLow=273.15 + 19,
    uHigh=273.15 + 21,
    realTrue=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Control.PI pI(TSet=TSupply - 5,
    release=true,
    PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=0,
      k=0.1,
      Ti=1000))                   annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-4})));
equation
  QHeaSys = 0;
  P[1] = 0;
  Q[1] = 0;

  connect(flowController.port_a1, flowPort_supply) annotation (Line(
      points={{116,-36},{160,-36},{160,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowController.port_b2, flowPort_return) annotation (Line(
      points={{116,-48},{120,-48},{120,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowController.port_b1, heatExchanger.port_a1) annotation (Line(
      points={{96,-36},{74,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b2, flowController.port_a2) annotation (Line(
      points={{74,-48},{96,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_b1, parallelPipesSplitter.port_a) annotation (Line(
      points={{54,-36},{30,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_b, heatExchanger.port_a2) annotation (Line(
      points={{30,-48},{54,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_aN, pumpSupply_m_flow.port_b2) annotation (
     Line(
      points={{10,-48},{0,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(parallelPipesSplitter.port_bN, pumpSupply_m_flow.port_a1) annotation (
     Line(
      points={{10,-36},{0,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpSupply_m_flow.port_b1, rad.port_a) annotation (Line(
      points={{-20,-36},{-32,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rad.port_b, pumpSupply_m_flow.port_a2) annotation (Line(
      points={{-52,-36},{-60,-36},{-60,-48},{-20,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], parallelPipesSplitter.port_a) annotation (Line(
      points={{36,-74},{50,-74},{50,-36},{30,-36}},
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
      points={{-59.2,40},{-10,40},{-10,-31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pI.y, flowController.u) annotation (Line(
      points={{100.6,-4},{106,-4},{106,-31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pI.senMassFlow1, heatExchanger.massFlow1) annotation (Line(
      points={{79.6,-12},{72,-12},{72,-31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pI.T1, heatExchanger.senT1) annotation (Line(
      points={{79.6,-8},{70,-8},{70,-31.4},{69.4,-31.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pI.senMassFlow2, heatExchanger.massFlow2) annotation (Line(
      points={{79.6,8.88178e-016},{59.2,8.88178e-016},{59.2,-31.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pI.senT2, heatExchanger.Tsup) annotation (Line(
      points={{79.6,4},{56.4,4},{56.4,-31.6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end HeatExchangerdp;

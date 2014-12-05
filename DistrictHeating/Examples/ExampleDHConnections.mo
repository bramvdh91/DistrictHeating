within DistrictHeating.Examples;
model ExampleDHConnections
  import IDEAS;
  extends Modelica.Icons.Example;

  inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Interfaces.BuildingDH nbuilding(
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare DistrictHeating.HeatingSystems.IndirectSH  heatingSystem(direct(
          KV=2.25, KVs=2.4)))
    annotation (Placement(transformation(extent={{-56,26},{-36,46}})));

  IDEAS.Fluid.Production.PolynomialProduction
                                  boiler(
    m_flow_nominal=0.5,
    dp_nominal=200,
    redeclare package Medium = IDEAS.Media.Water.Simple,
    QNom(displayUnit="kW") = 30000,
    redeclare IDEAS.Fluid.Production.Data.Polynomials.Boiler2ndDegree data)
                      annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=180,
        origin={80,5})));

  Modelica.Blocks.Sources.Constant const1(k=273 + 70)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Interfaces.DHConnection dHConnection(
    m_flow_nominal=0.5,
    Tsupply(allowFlowReversal=false),
    TReturn(allowFlowReversal=false),
    redeclare package Medium = IDEAS.Media.Water.Simple,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(L=20, dp_nominal=560),
    from_dp=true)
    annotation (Placement(transformation(extent={{-80,0},{-60,16}})));
  Interfaces.DHConnection dHConnection1(
    m_flow_nominal=0.5,
    redeclare package Medium = IDEAS.Media.Water.Simple,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      L=20,
      Do=0.32,
      Di=0.32,
      dp_nominal=845),
    from_dp=true)
    annotation (Placement(transformation(extent={{-56,0},{-36,16}})));
  Interfaces.BuildingDH building1(
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare DistrictHeating.HeatingSystems.IndirectSH  heatingSystem(direct(
          KV=3.8, KVs=2.4)))
    annotation (Placement(transformation(extent={{-80,26},{-60,46}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort supply(       m_flow_nominal=0.5,
      redeclare package Medium = IDEAS.Media.Water.Simple)
    annotation (Placement(transformation(extent={{60,18},{40,38}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort returnT(redeclare package Medium =
        IDEAS.Media.Water.Simple)
    annotation (Placement(transformation(extent={{20,-26},{40,-6}})));
  IDEAS.Fluid.Movers.FlowMachine_dp
                              fan1(
    motorCooledByFluid=false,
    m_flow_nominal=0.5,
    addPowerToMedium=false,
    redeclare package Medium = IDEAS.Media.Water.Simple)
                                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,28})));
  Modelica.Blocks.Sources.Constant Head(k=2)
    "Required pressure head of the pump"
    annotation (Placement(transformation(extent={{-60,-38},{-40,-18}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    use_T=false,
    h=0,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-20,-44},{0,-24}})));
  Modelica.Blocks.Sources.Constant HtodP(k=1000*9.81)
    "Conversion factor from head to dp"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Interfaces.DHConnection dHConnection2(
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      L=1,
      Do=0.32,
      Di=0.32,
      dp_nominal=18400),
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.1,
    from_dp=true)
    annotation (Placement(transformation(extent={{-32,0},{-12,16}})));
equation

  //BoilerViaPartials.TSet = sim.Te;
  connect(const1.y, boiler.TSet) annotation (Line(
      points={{61,-40},{76,-40},{76,-6.44}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(returnT.port_b, boiler.port_a) annotation (Line(
      points={{40,-16},{69.8,-16},{69.8,0.6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection.flowPort_supply_in, dHConnection1.flowPort_supply_out)
    annotation (Line(
      points={{-60,10},{-56,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(supply.port_a, boiler.port_b) annotation (Line(
      points={{60,28},{69.8,28},{69.8,9.4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection.flowPort_return_out, dHConnection1.flowPort_return_in)
    annotation (Line(
      points={{-60,6},{-56,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(supply.port_b, fan1.port_a) annotation (Line(
      points={{40,28},{20,28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(building1.flowPortReturnOut, dHConnection.flowPortIn) annotation (
      Line(
      points={{-72,26.2},{-72,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building1.flowPortSupplyIn, dHConnection.flowPortOut) annotation (
      Line(
      points={{-68,26.2},{-68,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(nbuilding.flowPortReturnOut, dHConnection1.flowPortIn) annotation (
      Line(
      points={{-48,26.2},{-48,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(nbuilding.flowPortSupplyIn, dHConnection1.flowPortOut) annotation (
      Line(
      points={{-44,26.2},{-44,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(boundary.ports[1], returnT.port_b) annotation (Line(
      points={{50,-10},{50,-16},{40,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Head.y, product.u1) annotation (Line(
      points={{-39,-28},{-22,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HtodP.y, product.u2) annotation (Line(
      points={{-39,-60},{-28,-60},{-28,-40},{-22,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, fan1.dp_in) annotation (Line(
      points={{1,-34},{10.2,-34},{10.2,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_supply_out, dHConnection1.flowPort_supply_in)
    annotation (Line(
      points={{-32,10},{-36,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_return_in, dHConnection1.flowPort_return_out)
    annotation (Line(
      points={{-32,6},{-36,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fan1.port_b, dHConnection2.flowPort_supply_in) annotation (Line(
      points={{0,28},{-12,28},{-12,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_return_out, returnT.port_a) annotation (Line(
      points={{-12,6},{-12,-16},{20,-16}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1e+006, Interval=3600),
    __Dymola_experimentSetupOutput);
end ExampleDHConnections;

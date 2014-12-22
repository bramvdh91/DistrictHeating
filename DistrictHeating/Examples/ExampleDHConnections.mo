within DistrictHeating.Examples;
model ExampleDHConnections
  import IDEAS;
  extends Modelica.Icons.Example;

  inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false,
    filDir="C:/Users/u0098668/Documents/Modelica/fmu-server/fmu/Inputs/")
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Interfaces.BuildingDH buildingRight(
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare DistrictHeating.HeatingSystems.IndirectSH heatingSystem(direct(KV=
           2.25, KVs=2.4)))
    annotation (Placement(transformation(extent={{-50,26},{-30,46}})));

  Modelica.Blocks.Sources.Constant boilerSetPoint(k=273 + 74)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Interfaces.BuildingDH buildingLeft(
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare DistrictHeating.HeatingSystems.IndirectSH heatingSystem(direct(KV=
           3.8, KVs=2.4)))
    annotation (Placement(transformation(extent={{-74,26},{-54,46}})));
  IDEAS.Fluid.Movers.FlowMachine_dp
                              fan1(
    motorCooledByFluid=false,
    m_flow_nominal=0.5,
    addPowerToMedium=false,
    redeclare package Medium = IDEAS.Media.Water.Simple)
                                   annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={16,28})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    use_T=false,
    h=0,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Interfaces.FixedHead fixedHead(pressureHead=2)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Interfaces.ThermostaticSafetyValve thermostaticSafetyValve(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.05,
    safetyT=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,8})));
  Interfaces.DHConnection dHConnection1(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      Do=0.32,
      Di=0.32,
      dp_nominal=200,
      L=20))
    annotation (Placement(transformation(extent={{-74,0},{-54,16}})));
  Interfaces.DHConnection dHConnection2(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      Do=0.32,
      Di=0.32,
      dp_nominal=200,
      L=20))
    annotation (Placement(transformation(extent={{-50,0},{-30,16}})));
  Interfaces.DHConnection dHConnection3(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      L=1,
      Do=0.32,
      Di=0.32,
      dp_nominal=1800,
      m_flow_nominal=0.05))
    annotation (Placement(transformation(extent={{-24,0},{-4,16}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort supplyT(redeclare package Medium =
        IDEAS.Media.Water.Simple)
    annotation (Placement(transformation(extent={{58,18},{38,38}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort returnT(redeclare package Medium =
        IDEAS.Media.Water.Simple)
    annotation (Placement(transformation(extent={{14,-30},{34,-10}})));
  IDEAS.Fluid.Production.IdealHeaterNew idealHeaterNew(redeclare package Medium
      = IDEAS.Media.Water.Simple, m_flow_nominal=0.05)
    annotation (Placement(transformation(extent={{92,14},{72,-6}})));
equation

  //BoilerViaPartials.TSet = sim.Te;

  connect(fixedHead.y, fan1.dp_in) annotation (Line(
      points={{0.6,50},{16.2,50},{16.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortIn, buildingLeft.flowPortReturnOut) annotation (
     Line(
      points={{-66,16},{-66,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortOut, buildingLeft.flowPortSupplyIn) annotation (
     Line(
      points={{-62,16},{-62,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_supply_out, thermostaticSafetyValve.port_a)
    annotation (Line(
      points={{-74,10},{-74,24},{-90,24},{-90,18}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(thermostaticSafetyValve.port_b, dHConnection1.flowPort_return_in)
    annotation (Line(
      points={{-90,-2},{-90,-8},{-74,-8},{-74,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fan1.port_b, dHConnection3.flowPort_supply_in) annotation (Line(
      points={{6,28},{-4,28},{-4,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection3.flowPort_supply_out, dHConnection2.flowPort_supply_in)
    annotation (Line(
      points={{-24,10},{-30,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_return_out, dHConnection3.flowPort_return_in)
    annotation (Line(
      points={{-30,6},{-24,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortIn, buildingRight.flowPortReturnOut)
    annotation (Line(
      points={{-42,16},{-42,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortOut, buildingRight.flowPortSupplyIn)
    annotation (Line(
      points={{-38,16},{-38,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_supply_out, dHConnection1.flowPort_supply_in)
    annotation (Line(
      points={{-50,10},{-54,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_return_out, dHConnection2.flowPort_return_in)
    annotation (Line(
      points={{-54,6},{-50,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fan1.port_a, supplyT.port_b) annotation (Line(
      points={{26,28},{38,28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection3.flowPort_return_out, returnT.port_a) annotation (Line(
      points={{-4,6},{-4,-20},{14,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(supplyT.port_a, idealHeaterNew.port_b) annotation (Line(
      points={{58,28},{72,28},{72,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnT.port_b, idealHeaterNew.port_a) annotation (Line(
      points={{34,-20},{72,-20},{72,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], idealHeaterNew.port_a) annotation (Line(
      points={{48,-10},{48,-20},{72,-20},{72,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boilerSetPoint.y, idealHeaterNew.TSet) annotation (Line(
      points={{61,-50},{78,-50},{78,-6.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fixedTemperature.port, idealHeaterNew.heatPort) annotation (Line(
      points={{80,50},{86,50},{86,14}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
            -100},{100,100}})),
    experiment(StopTime=604800, Interval=3600),
    __Dymola_experimentSetupOutput);
end ExampleDHConnections;

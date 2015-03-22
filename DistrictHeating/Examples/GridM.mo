within DistrictHeating.Examples;
model GridM
  import IDEAS;
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  package Medium=IDEAS.Media.Water.Simple;

  Modelica.Blocks.Sources.Constant boilerSetPoint(k=273.15 + 75)
    annotation (Placement(transformation(extent={{-2,-32},{18,-12}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    use_T=false,
    h=0,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-8,44})));
  Interfaces.ThermostaticSafetyValve thermostaticSafetyValve(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.05,
    safetyT=348.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,10})));
  Interfaces.DHConnection dHConnection1(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.05,
    length=20,
    from_dp=false,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(dp_nominal=100))
    annotation (Placement(transformation(extent={{-80,0},{-60,22}})));
  Interfaces.DHConnection dHConnection2(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.05,
    length=20,
    from_dp=false,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      Do=0.32,
      Di=0.32,
      dp_nominal=100))
    annotation (Placement(transformation(extent={{-50,0},{-30,22}})));
  IDEAS.Fluid.Production.IdealHeater idealHeater(m_flow_nominal=1)
    annotation (Placement(transformation(extent={{20,0},{0,20}})));
  IDEAS.Interfaces.Building building(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerM heatingSystem(QNom=
          {773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-80,32},{-60,52}})));
  IDEAS.Interfaces.Building building1(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerM heatingSystem(QNom=
          {1273.15,1273.15,773.15}))
    annotation (Placement(transformation(extent={{-50,32},{-30,52}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  inner IDEAS.Occupants.Extern.StrobeInfoManager strobe
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
equation

  //BoilerViaPartials.TSet = sim.Te;

  connect(dHConnection2.flowPort_supply_out, dHConnection1.flowPort_supply_in)
    annotation (Line(
      points={{-50,16},{-59.8,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_return_out, dHConnection2.flowPort_return_in)
    annotation (Line(
      points={{-60,4.2},{-60,4},{-62,4},{-62,4.2},{-50,4.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(boilerSetPoint.y, idealHeater.TSet) annotation (Line(
      points={{19,-22},{34,-22},{34,30},{14,30},{14,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortIn, building.flowPort_return) annotation (Line(
      points={{-72,22},{-72,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortOut, building.flowPort_supply) annotation (Line(
      points={{-68,22},{-68,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortIn, building1.flowPort_return) annotation (Line(
      points={{-42,22},{-42,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortOut, building1.flowPort_supply) annotation (
      Line(
      points={{-38,22},{-38,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_supply_in, idealHeater.port_b) annotation (
      Line(
      points={{-29.8,16},{0,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_return_out, idealHeater.port_a) annotation (
      Line(
      points={{-30,4.2},{-30,4},{0,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(boundary.ports[1], idealHeater.port_b) annotation (Line(
      points={{-8,34},{-8,16},{0,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_supply_out, thermostaticSafetyValve.flowPort_a)
    annotation (Line(
      points={{-80,16},{-90,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(thermostaticSafetyValve.flowPort_b, dHConnection1.flowPort_return_in)
    annotation (Line(
      points={{-90,4},{-80,4},{-80,4},{-80,4},{-80,4},{-80,4.2}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
            -100},{100,100}})),
    experiment(StopTime=604800, Interval=3600),
    __Dymola_experimentSetupOutput);
end GridM;

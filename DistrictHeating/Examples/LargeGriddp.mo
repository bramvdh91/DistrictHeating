within DistrictHeating.Examples;
model LargeGriddp
  import IDEAS;
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  package Medium=IDEAS.Media.Water.Simple;

  Modelica.Blocks.Sources.Constant boilerSetPoint(k=273.15 + 75)
    annotation (Placement(transformation(extent={{98,42},{78,62}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    use_T=false,
    h=0,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={52,62})));
  Interfaces.FixedHead fixedHead(pressureHead=5)
    annotation (Placement(transformation(extent={{0,54},{20,74}})));
  Interfaces.ThermostaticSafetyValve thermostaticSafetyValve(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=0.05,
    safetyT=348.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={24,-20})));
  Interfaces.DHConnection dHConnection1(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{-48,22},{-28,44}})));
  Interfaces.DHConnection dHConnection2(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    length=20,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      Do=0.32,
      Di=0.32,
      dp_nominal=200))
    annotation (Placement(transformation(extent={{-18,22},{2,44}})));
  IDEAS.Fluid.BaseCircuits.PumpSupply_dp pumpSupply_dp(
    KvReturn=5,
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=1,
    addPowerToMedium=false,
    measureSupplyT=true,
    measureReturnT=true)
    annotation (Placement(transformation(extent={{38,22},{18,42}})));
  IDEAS.Fluid.Production.IdealHeater idealHeater(m_flow_nominal=1)
    annotation (Placement(transformation(extent={{80,22},{60,42}})));
  IDEAS.Interfaces.Building building(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
  IDEAS.Interfaces.Building building1(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={1273.15,1273.15,773.15}))
    annotation (Placement(transformation(extent={{-18,54},{2,74}})));
  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Interfaces.DHConnection dHConnection3(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{-106,22},{-86,44}})));
  Interfaces.DHConnection dHConnection4(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    length=20,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe(
      Do=0.32,
      Di=0.32,
      dp_nominal=200))
    annotation (Placement(transformation(extent={{-76,22},{-56,44}})));
  IDEAS.Interfaces.Building building2(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-106,54},{-86,74}})));
  IDEAS.Interfaces.Building building3(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={1273.15,1273.15,773.15}))
    annotation (Placement(transformation(extent={{-76,54},{-56,74}})));
  Interfaces.DHConnection dHConnection5(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{-86,-30},{-106,-8}})));
  IDEAS.Interfaces.Building building4(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-86,-2},{-106,18}})));
  Interfaces.DHConnection dHConnection6(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{-56,-30},{-76,-8}})));
  IDEAS.Interfaces.Building building5(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-56,-2},{-76,18}})));
  Interfaces.DHConnection dHConnection7(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{-28,-30},{-48,-8}})));
  IDEAS.Interfaces.Building building6(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{-28,-2},{-48,18}})));
  Interfaces.DHConnection dHConnection8(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    from_dp=true,
    m_flow_nominal=0.05,
    redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe,
    length=20)
    annotation (Placement(transformation(extent={{2,-30},{-18,-8}})));
  IDEAS.Interfaces.Building building7(
    isDH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.Occupants.Standards.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    flowPort_return(redeclare package Medium = Medium),
    flowPort_supply(redeclare package Medium = Medium),
    redeclare DistrictHeating.HeatingSystems.HeatExchangerdp heatingSystem(
        redeclare package Medium = Medium, QNom={773.15,773.15,473.15}))
    annotation (Placement(transformation(extent={{2,-2},{-18,18}})));
equation

  //BoilerViaPartials.TSet = sim.Te;

  connect(dHConnection2.flowPort_supply_out, dHConnection1.flowPort_supply_in)
    annotation (Line(
      points={{-18,38},{-27.8,38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_return_out, dHConnection2.flowPort_return_in)
    annotation (Line(
      points={{-28,26.2},{-18,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fixedHead.y, pumpSupply_dp.u) annotation (Line(
      points={{20.6,64},{28,64},{28,42.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_supply_in, pumpSupply_dp.port_b1) annotation (
      Line(
      points={{2.2,38},{18,38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPort_return_out, pumpSupply_dp.port_a2) annotation (
     Line(
      points={{2,26.2},{18,26.2},{18,26}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(idealHeater.port_b, pumpSupply_dp.port_a1) annotation (Line(
      points={{60,38},{38,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpSupply_dp.port_b2, idealHeater.port_a) annotation (Line(
      points={{38,26},{60,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], pumpSupply_dp.port_a1) annotation (Line(
      points={{52,52},{52,38},{38,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boilerSetPoint.y, idealHeater.TSet) annotation (Line(
      points={{77,52},{74,52},{74,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortIn, building.flowPort_return) annotation (Line(
      points={{-40,44},{-40,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPortOut, building.flowPort_supply) annotation (Line(
      points={{-36,44},{-36,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortIn, building1.flowPort_return) annotation (Line(
      points={{-10,44},{-10,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection2.flowPortOut, building1.flowPort_supply) annotation (
      Line(
      points={{-6,44},{-6,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection4.flowPort_supply_out,dHConnection3. flowPort_supply_in)
    annotation (Line(
      points={{-76,38},{-85.8,38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection3.flowPort_return_out,dHConnection4. flowPort_return_in)
    annotation (Line(
      points={{-86,26.2},{-86,26},{-88,26},{-88,26.2},{-76,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection3.flowPortIn, building2.flowPort_return) annotation (Line(
      points={{-98,44},{-98,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection3.flowPortOut, building2.flowPort_supply) annotation (
      Line(
      points={{-94,44},{-94,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection4.flowPortIn,building3. flowPort_return) annotation (Line(
      points={{-68,44},{-68,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection4.flowPortOut,building3. flowPort_supply) annotation (
      Line(
      points={{-64,44},{-64,54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_supply_out, dHConnection4.flowPort_supply_in)
    annotation (Line(
      points={{-48,38},{-55.8,38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection1.flowPort_return_in, dHConnection4.flowPort_return_out)
    annotation (Line(
      points={{-48,26.2},{-56,26.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection3.flowPort_supply_out, dHConnection5.flowPort_supply_in)
    annotation (Line(
      points={{-106,38},{-114,38},{-114,-14},{-106.2,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection3.flowPort_return_in, dHConnection5.flowPort_return_out)
    annotation (Line(
      points={{-106,26.2},{-110,26.2},{-110,-25.8},{-106,-25.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection5.flowPort_supply_out, dHConnection6.flowPort_supply_in)
    annotation (Line(
      points={{-86,-14},{-76.2,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection5.flowPort_return_in, dHConnection6.flowPort_return_out)
    annotation (Line(
      points={{-86,-25.8},{-82,-25.8},{-82,-25.8},{-76,-25.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection6.flowPort_supply_out, dHConnection7.flowPort_supply_in)
    annotation (Line(
      points={{-56,-14},{-48.2,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection6.flowPort_return_in, dHConnection7.flowPort_return_out)
    annotation (Line(
      points={{-56,-25.8},{-52,-25.8},{-52,-25.8},{-48,-25.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection7.flowPort_supply_out, dHConnection8.flowPort_supply_in)
    annotation (Line(
      points={{-28,-14},{-18.2,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection7.flowPort_return_in, dHConnection8.flowPort_return_out)
    annotation (Line(
      points={{-28,-25.8},{-24,-25.8},{-24,-25.8},{-18,-25.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building4.flowPort_supply, dHConnection5.flowPortOut) annotation (
      Line(
      points={{-98,-2},{-98,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building4.flowPort_return, dHConnection5.flowPortIn) annotation (Line(
      points={{-94,-2},{-94,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building5.flowPort_supply, dHConnection6.flowPortOut) annotation (
      Line(
      points={{-68,-2},{-68,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building5.flowPort_return, dHConnection6.flowPortIn) annotation (Line(
      points={{-64,-2},{-64,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building6.flowPort_supply, dHConnection7.flowPortOut) annotation (
      Line(
      points={{-40,-2},{-40,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building6.flowPort_return, dHConnection7.flowPortIn) annotation (Line(
      points={{-36,-2},{-36,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building7.flowPort_supply, dHConnection8.flowPortOut) annotation (
      Line(
      points={{-10,-2},{-10,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building7.flowPort_return, dHConnection8.flowPortIn) annotation (Line(
      points={{-6,-2},{-6,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection8.flowPort_supply_out, thermostaticSafetyValve.flowPort_a)
    annotation (Line(
      points={{2,-14},{14,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection8.flowPort_return_in, thermostaticSafetyValve.flowPort_b)
    annotation (Line(
      points={{2,-25.8},{10,-25.8},{10,-26},{14,-26}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
            -100},{100,100}})),
    experiment(StopTime=604800, Interval=3600),
    __Dymola_experimentSetupOutput);
end LargeGriddp;

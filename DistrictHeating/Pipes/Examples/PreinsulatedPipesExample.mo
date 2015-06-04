within DistrictHeating.Pipes.Examples;
model PreinsulatedPipesExample

  //Extensions
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.FixedBoundary returnsink(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,70},{-72,90}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(extent={{92,38},{72,58}})));

  Modelica.Fluid.Sources.FixedBoundary supplysink(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{90,70},{70,90}})));

  Modelica.Blocks.Sources.Constant TGround(k=273 + 12)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  DoublePipes.PreinsulatedPipes preinsulatedPipes(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    L=100,
    rho=1000,
    lambdaG=1.5,
    lambdaI=0.026,
    H=1.5,
    E=0.35,
    dp_nominal=20,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    Do=0.25,
    Di=0.16,
    m_flow_nominal=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
             annotation (Placement(transformation(extent={{-16,46},{4,74}})));

  IDEAS.Fluid.BaseCircuits.Measurements measurements(redeclare package Medium
      = Buildings.Media.Water, m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
  IDEAS.Fluid.BaseCircuits.Measurements measurements1(redeclare package Medium
      = Buildings.Media.Water, m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{16,50},{36,70}})));
equation
  connect(TGround.y, preinsulatedPipes.Tg) annotation (Line(
      points={{-49,10},{-6,10},{-6,45.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.ports[1], measurements.port_a1) annotation (Line(
      points={{-72,80},{-62,80},{-62,66},{-52,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(measurements.port_b1, preinsulatedPipes.port_a1) annotation (Line(
      points={{-32,66},{-16,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(measurements.port_a2, preinsulatedPipes.port_b2) annotation (Line(
      points={{-32,54},{-16,54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(measurements.port_b2, returnsink.ports[1]) annotation (Line(
      points={{-52,54},{-62,54},{-62,48},{-74,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipes.port_b1, measurements1.port_a1) annotation (Line(
      points={{4,66},{16,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preinsulatedPipes.port_a2, measurements1.port_b2) annotation (Line(
      points={{4,54},{16,54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(measurements1.port_b1, supplysink.ports[1]) annotation (Line(
      points={{36,66},{52,66},{52,80},{70,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(measurements1.port_a2, boundary1.ports[1]) annotation (Line(
      points={{36,54},{50,54},{50,48},{72,48}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PreinsulatedPipesExample;

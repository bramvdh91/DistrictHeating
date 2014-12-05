within DistrictHeating.HeatingSystems.HydraulicCircuits;
model HeatExchanger
  extends BaseClasses.HydraulicCircuitPartial(pipe_Insulated2(m=m/2,
        m_flow_nominal=m1_flow_nominal), pipe_Insulated1(m=m/2, m_flow_nominal=
          m2_flow_nominal));

  //Parameters
  parameter Modelica.SIunits.Pressure p=200000
    "Absolute pressure on the secondary side";
  parameter Real efficiency=0.9 "Efficiency of the heat exchanger";
  parameter Modelica.SIunits.Pressure dp1_nominal=200
    "Pressure drop on the primary side";
  parameter Modelica.SIunits.Pressure dp2_nominal=200
    "Pressure drop on the secondary side";

  //Components
  IDEAS.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium1,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m1_flow_nominal,
    eps=efficiency,
    dp1_nominal=dp1_nominal,
    dp2_nominal=dp2_nominal) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,0})));
  IDEAS.Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
        Medium1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,34})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
  Modelica.Blocks.Interfaces.RealOutput senT1
    "Temperature of the supply line on the primary side" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,106})));
  Modelica.Blocks.Interfaces.RealOutput senMassFlow2
    "Massflow at the secondary side" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,106})));
  Modelica.Blocks.Interfaces.RealOutput senMassFlow1
    "Massflow at the secondary side" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,106})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{18,24},{38,44}})));
  Modelica.Blocks.Interfaces.RealOutput senT2
    "Temperature of the supply line on the primary side" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,106})));
  IDEAS.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Medium1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,32})));
equation
  connect(senMasFlo2.port_b, port_b1) annotation (Line(
      points={{70,34},{74,34},{74,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.T, senT1) annotation (Line(
      points={{-24,21},{-24,52},{-40,52},{-40,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem1.port_b, hex.port_a1) annotation (Line(
      points={{-14,10},{-6,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, port_a2) annotation (Line(
      points={{6,-10},{6,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo2.m_flow, senMassFlow2) annotation (Line(
      points={{60,45},{60,80},{80,80},{80,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hex.port_b2, senTem2.port_a) annotation (Line(
      points={{6,10},{6,34},{18,34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.port_b, senMasFlo2.port_a) annotation (Line(
      points={{38,34},{50,34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.T, senT2) annotation (Line(
      points={{28,45},{28,80},{40,80},{40,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe_Insulated2.port_b, senMasFlo1.port_a) annotation (Line(
      points={{-70,60},{-60,60},{-60,32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, senMassFlow1) annotation (Line(
      points={{-70,43},{-70,50},{-66,50},{-66,80},{-80,80},{-80,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem1.port_a, senMasFlo1.port_b) annotation (Line(
      points={{-34,10},{-80,10},{-80,32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated1.port_a, hex.port_b1) annotation (Line(
      points={{-70,-60},{-70,-12},{-6,-12},{-6,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-42,76},{44,-76}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-42,76},{44,-76}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-42,76},{-42,-76},{44,-76},{-42,76}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}));
end HeatExchanger;

within DistrictHeating.Interfaces;
model ThermostaticSafetyValve

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  //Parameter
  parameter Modelica.SIunits.Temperature safetyT
    "Minimal temperature on the supply side of the valve";

  IDEAS.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=20000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.PI, Ti=1800)
    annotation (Placement(transformation(extent={{-40,38},{-20,58}})));
  IDEAS.Fluid.Sensors.Temperature senTem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-62,8},{-42,28}})));
  Modelica.Blocks.Sources.Constant const(k=safetyT)
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-4,44},{16,64}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
equation
  connect(port_a, val.port_a) annotation (Line(
      points={{-100,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port, val.port_a) annotation (Line(
      points={{-52,8},{-52,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.T, PID.u_m) annotation (Line(
      points={{-45,18},{-30,18},{-30,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(val.port_b, port_b) annotation (Line(
      points={{10,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, PID.u_s) annotation (Line(
      points={{-59,48},{-42,48}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(PID.y, max.u2) annotation (Line(
      points={{-19,48},{-6,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zero.y, max.u1) annotation (Line(
      points={{-19,80},{-10,80},{-10,60},{-6,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(max.y, val.y) annotation (Line(
      points={{17,54},{24,54},{24,20},{0,20},{0,12}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Line(
          points={{0,42},{0,102}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          visible=filteredOpening,
          extent={{-32,42},{32,102}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=filteredOpening,
          extent={{-32,102},{32,42}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,94},{20,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="T"),
        Polygon(
          points={{2,0},{-76,62},{-76,-58},{2,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,42},{0,0},{54,42},{54,42},{-50,42}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,-40},{0,-2},{60,42},{60,-40},{-52,-40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,0},{82,62},{82,-58},{0,0}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,42},{0,-2}},
          color={0,0,0},
          smooth=Smooth.None),     Text(
          extent={{-74,22},{-36,-22}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%"),
        Rectangle(
          extent={{82,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255})}));
end ThermostaticSafetyValve;

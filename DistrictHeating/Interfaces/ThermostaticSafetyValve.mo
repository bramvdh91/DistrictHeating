within DistrictHeating.Interfaces;
model ThermostaticSafetyValve

  //Extensions
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

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
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_b
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_a
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
equation
  connect(senTem.port, val.port_a) annotation (Line(
      points={{-52,8},{-52,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.T, PID.u_m) annotation (Line(
      points={{-45,18},{-30,18},{-30,36}},
      color={0,0,127},
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
  connect(val.port_b, flowPort_b) annotation (Line(
      points={{10,0},{40,0},{40,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_a, val.port_a) annotation (Line(
      points={{100,60},{28,60},{28,94},{-90,94},{-90,0},{-10,0}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,40},{40,40},{0,-12},{-40,40}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,30},{40,30},{2,-20},{-40,30}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={0,-10},
          rotation=180),
        Rectangle(
          visible=filteredOpening,
          extent={{-32,-30},{32,30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=filteredOpening,
          extent={{-32,30},{32,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,22},{20,-22}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="T"),
        Line(
          points={{90,60},{0,60},{0,40}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-40},{0,-60},{94,-60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end ThermostaticSafetyValve;

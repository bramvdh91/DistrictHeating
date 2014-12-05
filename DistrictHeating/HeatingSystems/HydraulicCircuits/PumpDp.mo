within DistrictHeating.HeatingSystems.HydraulicCircuits;
model PumpDp "Base circuit controlled by a single pump"

  //Extensions
  extends BaseClasses.HydraulicCircuitPartial(
    redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
    redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple);

  //Parameters
  parameter Real KV = 30 "KV value of the balancing valve";

  IDEAS.Fluid.Movers.FlowMachine_dp fan(
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Interfaces.RealInput u "Control input signal"
                                       annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,114})));
  IDEAS.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Medium1,
    CvData=IDEAS.Fluid.Types.CvTypes.Kv,
    Kv=KV) annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Modelica.Blocks.Sources.Constant hlift(k=1)
    "Constant opening of the balancing valve"
    annotation (Placement(transformation(extent={{-38,-20},{-18,0}})));
equation
  connect(fan.port_b, port_b1) annotation (Line(
      points={{10,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated2.port_b, fan.port_a) annotation (Line(
      points={{-70,60},{-10,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, fan.dp_in) annotation (Line(
      points={{0,114},{0,94},{0,72},{-0.2,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(val1.port_b, pipe_Insulated1.port_a) annotation (Line(
      points={{-10,-60},{-70,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hlift.y,val1. y) annotation (Line(
      points={{-17,-10},{0,-10},{0,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(val1.port_a, port_a2) annotation (Line(
      points={{10,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-10,10},{-10,-22},{22,-6},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-2,66},
          rotation=360),
        Ellipse(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,10},{-10,-22},{22,-6},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-2,66},
          rotation=360),
        Text(
          extent={{-10,70},{8,50}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="dP"),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-10,-60},
          rotation=360),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={10,-60},
          rotation=180),
        Line(
          points={{0,-60},{0,-44}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-6,-44},{6,-44}},
          color={0,0,255},
          smooth=Smooth.None)}));
end PumpDp;

within DistrictHeating.HeatingSystems.HydraulicCircuits;
model ExpansionCircuit

  //Extensions
  extends BaseClasses.HydraulicCircuitPartial;

  parameter Real KV = 30 "KV value of the balancing valve";
  parameter Real KVs = 30 "KVs value of the control valve";

  IDEAS.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    m_flow(nominal=0.1),
    redeclare package Medium = Medium1,
    dpValve_nominal=20,
    m_flow_nominal=0.1,
    from_dp=from_dp,
    CvData=IDEAS.Fluid.Types.CvTypes.Kv,
    Kv=KVs) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  IDEAS.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Medium1,
    CvData=IDEAS.Fluid.Types.CvTypes.Kv,
    Kv=KV,
    m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Modelica.Blocks.Interfaces.RealInput u "Control input signal"
                                       annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,114})));
  Modelica.Blocks.Sources.Constant hlift(k=1)
    "Constant opening of the balancing valve"
    annotation (Placement(transformation(extent={{-38,-20},{-18,0}})));
equation
  connect(val.port_b, port_b1) annotation (Line(
      points={{10,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated2.port_b, val.port_a) annotation (Line(
      points={{-70,60},{-10,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.port_b, pipe_Insulated1.port_a) annotation (Line(
      points={{-10,-60},{-70,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.port_a, port_a2) annotation (Line(
      points={{10,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, val.y) annotation (Line(
      points={{0,114},{0,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hlift.y, val1.y) annotation (Line(
      points={{-17,-10},{0,-10},{0,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
        Polygon(
          points={{-20,70},{-20,50},{0,60},{-20,70}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={10,60},
          rotation=180),
        Line(
          points={{0,60},{0,76}},
          color={0,0,255},
          smooth=Smooth.None),
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
          smooth=Smooth.None),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-10,-60},
          rotation=360),
        Rectangle(
          extent={{-6,88},{6,76}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid)}));
end ExpansionCircuit;

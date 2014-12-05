within DistrictHeating.HeatingSystems.HydraulicCircuits;
model Splitter
  extends BaseClasses.HydraulicCircuitPartial;

  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
    redeclare replaceable package Medium = Medium1,
    m_flow_nominal={m1_flow_nominal,m1_flow_nominal,-m1_flow_nominal},
    dp_nominal={-20,20,-20}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,60})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare replaceable package Medium = Medium1,
    m_flow_nominal={m1_flow_nominal,m1_flow_nominal,-m1_flow_nominal},
    dp_nominal={-20,20,-20}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-60})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(
                     redeclare final package Medium = Medium1,
                     m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                     h_outflow(start=h_outflow_a1_start))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}},
            rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(
                     redeclare final package Medium = Medium1,
                     m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                     h_outflow(start=h_outflow_b1_start))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{50,-110},{30,-90}},rotation=
             0), iconTransformation(extent={{50,-110},{30,-90}})));
equation
  connect(pipe_Insulated2.port_b, spl1.port_2) annotation (Line(
      points={{-70,60},{30,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl1.port_1, port_b1) annotation (Line(
      points={{50,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated1.port_a, spl2.port_2) annotation (Line(
      points={{-70,-60},{-50,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_1, port_a2) annotation (Line(
      points={{-30,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_3, port_a3) annotation (Line(
      points={{-40,-70},{-40,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl1.port_3, port_b3) annotation (Line(
      points={{40,50},{40,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b3, port_b3) annotation (Line(
      points={{40,-100},{40,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Line(
          points={{40,-100},{40,60}},
          color={0,128,255},
          smooth=Smooth.None), Line(
          points={{-40,-100},{-40,-60}},
          color={0,128,255},
          smooth=Smooth.None)}));
end Splitter;

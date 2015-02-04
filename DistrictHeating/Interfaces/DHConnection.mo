within DistrictHeating.Interfaces;
model DHConnection

  //Packages
  replaceable package Medium =Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"  annotation (choicesAllMatching = true);

  //Parameters
  parameter Boolean from_dp=false;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.Length length;

  //Components
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_supply_out(redeclare package
      Medium = Medium) "Supply line out connection"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}}),
        iconTransformation(extent={{-110,10},{-90,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in(redeclare package Medium
      = Medium) "Supply line in connection"
    annotation (Placement(transformation(extent={{92,10},{112,30}}),
        iconTransformation(extent={{92,10},{112,30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in(redeclare package Medium
      = Medium) "Return line in connection"
    annotation (Placement(transformation(extent={{-110,-108},{-90,-88}}),
        iconTransformation(extent={{-110,-108},{-90,-88}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out(redeclare package
      Medium = Medium) "Return line out connection"
    annotation (Placement(transformation(extent={{90,-108},{110,-88}}),
        iconTransformation(extent={{90,-108},{110,-88}})));

  replaceable Pipes.BaseClasses.DistrictHeatingPipe districtHeatingPipe(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      L=length)
    annotation (Placement(transformation(extent={{48,-74},{28,-46}})), choicesAllMatching=true);
  IDEAS.Fluid.Interfaces.FlowPort_a flowPortIn(redeclare package Medium =
        Medium) "Return line from the building"
    annotation (Placement(transformation(extent={{-30,70},{-10,90}}),
        iconTransformation(extent={{-30,70},{-10,90}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPortOut(redeclare package Medium =
        Medium) "Supply line to the building"
    annotation (Placement(transformation(extent={{10,70},{30,90}}),
        iconTransformation(extent={{10,70},{30,90}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
    annotation (Placement(transformation(extent={{6,-116},{26,-96}})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,-4})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Medium) "Sensor of the return temperature"
                                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,-18})));
equation
  connect(districtHeatingPipe.port_a1, flowPort_supply_in) annotation (Line(
      points={{48,-54},{60,-54},{60,20},{102,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression.y, districtHeatingPipe.Tg) annotation (Line(
      points={{27,-106},{38,-106},{38,-74.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowPortOut, Tsupply.port_b) annotation (Line(
      points={{20,80},{20,6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(TReturn.port_a, flowPortIn) annotation (Line(
      points={{-20,-8},{-20,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b2, flowPort_return_out) annotation (Line(
      points={{48,-66},{60,-66},{60,-98},{100,-98}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_return_in, districtHeatingPipe.port_a2) annotation (Line(
      points={{-100,-98},{-8,-98},{-8,-66},{28,-66}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b1, flowPort_supply_out) annotation (Line(
      points={{28,-54},{0,-54},{0,20},{-100,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_b, districtHeatingPipe.port_a2) annotation (Line(
      points={{-20,-28},{-20,-80},{-8,-80},{-8,-66},{28,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tsupply.port_a, flowPort_supply_out) annotation (Line(
      points={{20,-14},{20,-54},{0,-54},{0,20},{-100,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_return_in, flowPort_return_in) annotation (Line(
      points={{-100,-98},{-100,-98}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{100,80}}),  graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-140},{100,80}}),
                                               graphics={
        Rectangle(
          extent={{-100,60},{100,-140}},
          lineColor={135,135,135},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Polygon(
          points={{15,11},{-15,1},{15,-11},{15,11}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-19,-85},
          rotation=90),
        Polygon(
          points={{15,11},{-15,1},{15,-11},{15,11}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={65,-99},
          rotation=180),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-19,-81},
          rotation=90),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-65,19},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-61,19},
          rotation=180),
        Line(
          points={{-92,20},{92,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,55},
          rotation=90),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,51},
          rotation=90),
        Line(
          points={{20,60},{20,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={61,-99},
          rotation=180),
        Line(
          points={{-20,70},{-20,-92}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{100,-100},{-102,-100}},
          color={0,0,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{18,22},{22,18}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-98},{-18,-102}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,30},{80,10}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2,-88},{38,-108}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          extent={{-36,-64},{120,-32}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%length m
")}));
end DHConnection;

within DistrictHeating.Interfaces;
model DHConnection

  //Extensions
  extends IDEAS.Fluid.BaseCircuits.Interfaces.PartialBaseCircuit(
    final includePipes=false,
    measureSupplyT=false,
    measureReturnT=false);

  //Parameters
  parameter Modelica.SIunits.Length length;
  final parameter Modelica.SIunits.Pressure dp_nominal=
    districtHeatingPipe.dp_nominal * districtHeatingPipe.L
    "Nominal pressure losses over the connection";

  //Components

  replaceable Pipes.DoublePipes.TwinPipeGround districtHeatingPipe(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      L=length,
    Pipe1(energyDynamics=energyDynamics,
        massDynamics=massDynamics),
    Pipe2(energyDynamics=energyDynamics,
        massDynamics=massDynamics),
    TIn1(tau=tauTSensor),
    TOut2(tau=tauTSensor),
    TOut1(tau=tauTSensor),
    TIn2(tau=tauTSensor)) constrainedby Pipes.BaseClasses.DistrictHeatingPipe(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      L=length,
    Pipe1(energyDynamics=energyDynamics,
        massDynamics=massDynamics),
    Pipe2(energyDynamics=energyDynamics,
        massDynamics=massDynamics),
    TIn1(tau=tauTSensor),
    TOut2(tau=tauTSensor),
    TOut1(tau=tauTSensor),
    TIn2(tau=tauTSensor))
    annotation (Placement(transformation(extent={{-50,40},{-30,68}})), choicesAllMatching=true);
  IDEAS.Fluid.Interfaces.FlowPort_a flowPortIn(redeclare package Medium =
        Medium) "Return line from the building"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}}),
        iconTransformation(extent={{-30,90},{-10,110}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPortOut(redeclare package Medium =
        Medium) "Supply line to the building"
    annotation (Placement(transformation(extent={{10,90},{30,110}}),
        iconTransformation(extent={{10,90},{30,110}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
    annotation (Placement(transformation(extent={{-14,10},{-34,30}})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
equation
  if not measureSupplyT then
    connect(districtHeatingPipe.port_b1, port_b1);
  end if;

  if not measureReturnT then
    connect(districtHeatingPipe.port_b2, port_b2);
  end if;

  connect(realExpression.y, districtHeatingPipe.Tg) annotation (Line(
      points={{-35,20},{-40,20},{-40,39.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(port_a2, districtHeatingPipe.port_a2) annotation (Line(
      points={{100,-60},{40,-60},{40,48},{-30,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPortIn, districtHeatingPipe.port_a2) annotation (Line(
      points={{-20,100},{-20,48},{-30,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b1, senTemSup.port_a) annotation (Line(
      points={{-30,60},{60,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_a1, port_a1) annotation (Line(
      points={{-50,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b2, senTemRet.port_a) annotation (Line(
      points={{-50,48},{-60,48},{-60,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(districtHeatingPipe.port_b1, flowPortOut) annotation (Line(
      points={{-30,60},{20,60},{20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
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
          origin={-19,-47},
          rotation=90),
        Polygon(
          points={{15,11},{-15,1},{15,-11},{15,11}},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={77,-61},
          rotation=180),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-19,-41},
          rotation=90),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-75,59},
          rotation=180),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={-71,59},
          rotation=180),
        Line(
          points={{-94,60},{90,60}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-15,9},{15,-1},{-15,-11},{-15,9}},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,77},
          rotation=90),
        Polygon(
          points={{-11,5},{9,-1},{-11,-7},{-11,5}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={19,73},
          rotation=90),
        Line(
          points={{20,100},{20,60}},
          color={255,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{11,7},{-11,1},{11,-7},{11,7}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          origin={73,-61},
          rotation=180),
        Line(
          points={{-20,100},{-20,-62}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{102,-62},{-100,-62}},
          color={0,0,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{18,62},{22,58}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-60},{-18,-64}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,70},{80,50}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2,-52},{38,-72}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          extent={{-42,-18},{114,14}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%length m
")}));
end DHConnection;

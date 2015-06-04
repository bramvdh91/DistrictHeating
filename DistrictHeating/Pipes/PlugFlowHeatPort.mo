within DistrictHeating.Pipes;
model PlugFlowHeatPort
  "Pipe model with a temperature plug flow, pressure losses and heat exchange to the environment"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  //Interface
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
            {10,110}})));

  //Components
  DistrictHeating.Pipes.PlugFlowPipe plugFlowPipe(
    pipeLength=pipeLength,
    pipeDiameter=pipeDiameter,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

equation
  // Mass balance (no storage)
  plugFlowPipe.port_b.m_flow + port_b.m_flow = 0;

  // Transport of substances
  plugFlowPipe.port_b.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(plugFlowPipe.port_b.Xi_outflow);

  plugFlowPipe.port_b.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(plugFlowPipe.port_b.C_outflow);

  // Energy balance
  plugFlowPipe.port_b.h_outflow-port_b.h_outflow = heatPort.Q_flow/m_flow;
  dp=plugFlowPipe.dp;

  connect(port_a, plugFlowPipe.port_a) annotation (Line(
      points={{-100,0},{-20,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Polygon(
          points={{20,-70},{60,-85},{20,-100},{20,-70}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-26,24},{30,-22}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(
          points={{55,-85},{-60,-85}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),                                                                                 Polygon(          points={{
              -10,-35},{-10,15},{0,35},{10,15},{10,-35},{-10,-35}},                                                                                                    lineColor={255,0,0},
            fillPattern =                                                                                                   FillPattern.Forward,          fillColor={255,255,255},
          origin={0,59},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end PlugFlowHeatPort;

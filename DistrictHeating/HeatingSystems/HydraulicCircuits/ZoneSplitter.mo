within DistrictHeating.HeatingSystems.HydraulicCircuits;
model ZoneSplitter
  "Model to split a fluid inlet into multiple outlets and back"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component";

  //Parameters
  parameter Integer n(min=1) "Number of outgoing connections";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal flow rate";
  parameter Modelica.SIunits.Volume V "Volume of the piping";

  //Components
  Modelica.Fluid.Interfaces.FluidPort_b port_bN[n](
    redeclare final package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,92},{-50,112}},
            rotation=0), iconTransformation(extent={{-70,92},{-50,112}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_aN[n](
    redeclare final package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{70,92},{50,112}},  rotation=
             0), iconTransformation(extent={{70,92},{50,112}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium =Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-108},{-50,-88}},
          rotation=0), iconTransformation(extent={{-70,-108},{-50,-88}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{70,-110},{50,-90}}, rotation=0),
        iconTransformation(extent={{70,-110},{50,-90}})));
  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    nPorts=n + 1,
    V=V) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,14})));
equation
  for i in 1:n loop
    connect(port_bN[i], port_a);
  end for;

  connect(port_aN, vol.ports[1:n]);
  connect(port_b, vol.ports[end]);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Line(
          points={{-60,-100},{-60,102},{-60,100}},
          color={0,0,255},
          smooth=Smooth.None)}), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{10,0},{-10,-20},{-10,20}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={0,-30},
          rotation=90),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={0,60},
          rotation=270),
        Line(
          points={{20,-20},{-20,20},{-20,-20}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={0,40},
          rotation=90),
        Ellipse(extent={{40,80},{-40,0}}, lineColor={0,0,255}),
        Ellipse(extent={{40,0},{-40,-80}}, lineColor={0,0,255}),
        Line(
          points={{-60,-100},{-60,-74},{-60,-60},{-40,-40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{60,-100},{60,-60},{40,-40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{60,100},{60,60},{40,40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,100},{-60,60},{-40,40}},
          color={0,0,255},
          smooth=Smooth.None)}));
end ZoneSplitter;

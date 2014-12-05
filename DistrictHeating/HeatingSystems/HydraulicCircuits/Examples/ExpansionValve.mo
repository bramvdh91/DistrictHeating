within DistrictHeating.HeatingSystems.HydraulicCircuits.Examples;
model ExpansionValve
  IDEAS.Fluid.Sources.FixedBoundary bou(
    nPorts=1,
    redeclare package Medium = IDEAS.Media.Water.Simple,
    p=200000) annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
  IDEAS.Fluid.Sources.FixedBoundary bou1(
    nPorts=1,
    redeclare package Medium = IDEAS.Media.Water.Simple,
    p=300000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,18})));
  IDEAS.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = IDEAS.Media.Water.Simple,
    m_flow_nominal=1,
    CvData=IDEAS.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal(displayUnit="bar") = 100000)
    annotation (Placement(transformation(extent={{-10,8},{10,28}})));
equation
  connect(bou.ports[1], val.port_a) annotation (Line(
      points={{-60,18},{-10,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val.port_b, bou1.ports[1]) annotation (Line(
      points={{10,18},{60,18}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics));
end ExpansionValve;

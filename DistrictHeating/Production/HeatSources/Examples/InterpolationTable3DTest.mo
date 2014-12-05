within DistrictHeating.Production.HeatSources.Examples;
model InterpolationTable3DTest
  extends Modelica.Icons.Example;

  IDEAS.Utilities.Tables.InterpolationTable3D interpolationTable3D(space=boiler.space)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Data.PerformanceMaps.Boiler boiler
    annotation (Placement(transformation(extent={{-8,22},{12,42}})));
  Modelica.Blocks.Sources.Constant const(k=60)
    annotation (Placement(transformation(extent={{-68,30},{-48,50}})));
  Modelica.Blocks.Sources.Constant const1(k=700)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Blocks.Sources.Constant const2(k=100)
    annotation (Placement(transformation(extent={{-68,-46},{-48,-26}})));
equation
  connect(const.y, interpolationTable3D.u1) annotation (Line(
      points={{-47,40},{-20,40},{-20,6},{-8.8,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(interpolationTable3D.u2, const1.y) annotation (Line(
      points={{-8.8,0},{-47,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const2.y, interpolationTable3D.u3) annotation (Line(
      points={{-47,-36},{-32,-36},{-32,-6},{-8.8,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics));
end InterpolationTable3DTest;

within DistrictHeating.Examples;
model Example2 "Extension of example 1, including distribution heat losses"
  extends Examples.Example(
    fan1(addPowerToMedium=false),
    pipe_Insulated(m=100),
    pipe_Insulated1(m=100),
    pipe_Insulated3(m=100),
    pipe_Insulated2(m=100),
    pipe_Insulated4(m=100));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-106,-84},{-86,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
    annotation (Placement(transformation(extent={{-136,-86},{-116,-66}})));
equation
  connect(realExpression.y, prescribedTemperature.T) annotation (Line(
      points={{-115,-76},{-112,-76},{-112,-74},{-108,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{100,100}}), graphics));
end Example2;

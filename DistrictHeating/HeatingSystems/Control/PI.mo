within DistrictHeating.HeatingSystems.Control;
model PI

  //Extensions
  extends PartialHXControl;

  parameter Boolean release=true;
  parameter Modelica.SIunits.Temperature TSet=70;

  parameter Real threshold=0.0001 "Greater than threshold";

  Modelica.Blocks.Math.Product product if release
    annotation (Placement(transformation(extent={{16,-10},{36,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(
    threshold=threshold) if release
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,68})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 if release
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,24})));
  Modelica.Blocks.Continuous.LimPID PID
    annotation (Placement(transformation(extent={{-60,14},{-40,34}})));
  Modelica.Blocks.Sources.Constant const(k=TSet)
    annotation (Placement(transformation(extent={{-84,-60},{-64,-40}})));
equation
    connect(greaterThreshold.y,booleanToReal1. u) annotation (Line(
      points={{-1.9984e-015,57},{-1.9984e-015,48},{2.22045e-015,48},{2.22045e-015,
          36}},
      color={255,0,255},
      smooth=Smooth.None));
    connect(booleanToReal1.y,product. u1) annotation (Line(
      points={{-1.9984e-015,13},{-1.9984e-015,6},{14,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID.y, product.u2) annotation (Line(
      points={{-39,24},{-20,24},{-20,-6},{14,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, y) annotation (Line(
      points={{37,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMassFlow2, greaterThreshold.u) annotation (Line(
      points={{104,80},{28,80},{28,92},{0,92},{0,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senT2, PID.u_m) annotation (Line(
      points={{104,40},{12,40},{12,50},{-82,50},{-82,-8},{-50,-8},{-50,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, PID.u_s) annotation (Line(
      points={{-63,-50},{-50,-50},{-50,-16},{-70,-16},{-70,24},{-62,24}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(graphics={   Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
        Text(
          extent={{-20,-20},{80,-60}},
          lineColor={192,192,192},
          textString="%controllerType")}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PI;

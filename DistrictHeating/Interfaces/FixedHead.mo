within DistrictHeating.Interfaces;
model FixedHead "Constant fixed pressure head"

  //Parameters
  parameter Real pressureHead;

  //Components
  Modelica.Blocks.Sources.Constant Head(k=2)
    "Required pressure head of the pump"
    annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Sources.Constant HtodP(k=1000*9.81)
    "Conversion factor from head to dp"
    annotation (Placement(transformation(extent={{-46,-30},{-26,-10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
equation
  connect(Head.y,product. u1) annotation (Line(
      points={{-25,20},{-18,20},{-18,6},{-10,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HtodP.y,product. u2) annotation (Line(
      points={{-25,-20},{-16,-20},{-16,-6},{-10,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, y) annotation (Line(
      points={{13,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{36,24},{84,-24}},
          lineColor={0,127,0},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,78},{8,-80}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,80},{8,76}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,-78},{8,-82}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,44},{8,-80}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,46},{8,42}},
          lineColor={0,128,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{40,20},{80,-20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,20},{60,14}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{40,0},{46,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{74,0},{80,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{60,-14},{60,-20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{46,-14},{50,-10}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{70,10},{74,14}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{46,14},{50,10}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{70,-10},{74,-14}},
          color={0,0,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{58,2},{62,-2}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,0},{68,18}},
          color={0,127,0},
          smooth=Smooth.None),
        Polygon(
          points={{64,16},{68,14},{68,18},{64,16}},
          lineColor={0,127,0},
          smooth=Smooth.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{4,-72},{24,-76}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-76},{24,2}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,2},{36,-2}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,-72},{6,-76}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{84,0},{104,0}},
          color={0,0,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics));
end FixedHead;

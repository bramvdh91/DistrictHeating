within DistrictHeating.HeatingSystems.Control;
model SupplyTControl
  extends PartialHXControl;

  Hysteresis hysteresis(
    release=true,
    realTrue=0,
    realFalse=1,
    uLow=273.15 + 68,
    uHigh=273.15 + 72)
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
equation
  connect(hysteresis.y, y) annotation (Line(
      points={{4.8,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMassFlow2, hysteresis.u1) annotation (Line(
      points={{104,80},{-6,80},{-6,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T1, hysteresis.u) annotation (Line(
      points={{104,-40},{-28,-40},{-28,0},{-17.2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-29}}, color={192,192,192}),
        Polygon(
          points={{92,-29},{70,-21},{70,-37},{92,-29}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,-29},{84,-29}}, color={192,192,192}),
        Line(points={{-79,-29},{41,-29}}, color={0,0,0}),
        Line(points={{-15,-21},{1,-29},{-15,-36}}, color={0,0,0}),
        Line(points={{41,51},{41,-29}}, color={0,0,0}),
        Line(points={{33,3},{41,22},{50,3}}, color={0,0,0}),
        Line(points={{-49,51},{81,51}}, color={0,0,0}),
        Line(points={{-4,59},{-19,51},{-4,43}}, color={0,0,0}),
        Line(points={{-59,29},{-49,11},{-39,29}}, color={0,0,0}),
        Line(points={{-49,51},{-49,-29}}, color={0,0,0}),
        Text(
          extent={{-92,-49},{-9,-92}},
          lineColor={192,192,192},
          textString="%uLow"),
        Text(
          extent={{2,-49},{91,-92}},
          lineColor={192,192,192},
          textString="%uHigh"),
        Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
        Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
        Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
        Line(points={{41,-29},{41,-49}}, color={192,192,192}),
        Text(
          extent={{40,-28},{-48,50}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T")}));
end SupplyTControl;

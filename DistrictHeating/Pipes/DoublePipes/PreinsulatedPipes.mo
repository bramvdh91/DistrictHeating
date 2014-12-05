within DistrictHeating.Pipes.DoublePipes;
model PreinsulatedPipes
  "A symmetrical preinsulated pipe model where each pipe has its own insulation"

  //Extensions
  extends BaseClasses.DistrictHeatingPipe(
    hs=1/hsInvers,
    ha=1/haInvers,
    Do=0.25);

  //Parameters
protected
  parameter Real hsInvers=
    Modelica.Math.log(2*Heff/ro) + beta +
    Modelica.Math.log(sqrt(1 + (Heff/D)^2));
  parameter Real haInvers=
    Modelica.Math.log(2*Heff/ro) + beta -
    Modelica.Math.log(sqrt(1 + (Heff/D)^2));

equation
  Qs=(Ts-Tg)*2*Modelica.Constants.pi*lambdaG*hs;
  Qa=Ta*2*Modelica.Constants.pi*lambdaG*ha;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,120}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-140},{100,140}}), graphics={
        Ellipse(
          extent={{-40,-20},{40,-100}},
          lineColor={135,135,135},
          fillPattern=FillPattern.Forward,
          fillColor={255,255,255},
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-40,100},{40,20}},
          lineColor={135,135,135},
          fillPattern=FillPattern.Forward,
          fillColor={255,255,255},
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{30,30},{-30,90}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{30,-90},{-30,-30}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-100,-140},{100,-114}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-100,-114},{-100,-140},{-100,-114},{100,-114},{100,-140}},
          color={255,255,255},
          smooth=Smooth.None)}));
end PreinsulatedPipes;

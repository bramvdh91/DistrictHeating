within DistrictHeating.HeatingSystems.HydraulicCircuits.BaseClasses;
partial model HydraulicCircuitPartial "Partial for a hydraulic circuit"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialFourPortInterface(
    redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
    redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple);
  //Parameters
  parameter Boolean from_dp=true;
  parameter Modelica.SIunits.Mass m(start=1)=1
    "Mass of medium in the return and supply pipe";
  parameter Modelica.SIunits.ThermalConductance UA=10
    "Thermal conductance of the insulation";

  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated2(
    redeclare package Medium = Medium1,
    m=m,
    UA=UA,
    m_flow_nominal=m1_flow_nominal) annotation (Placement(transformation(
        extent={{-10,4},{10,-4}},
        rotation=0,
        origin={-80,60})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
    redeclare package Medium = Medium1,
    m=m,
    UA=UA,
    m_flow_nominal=m2_flow_nominal) annotation (Placement(transformation(
        extent={{-10,4},{10,-4}},
        rotation=180,
        origin={-80,-60})));
equation
  connect(port_a1, pipe_Insulated2.port_a) annotation (Line(
      points={{-100,60},{-90,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b2, pipe_Insulated1.port_b) annotation (Line(
      points={{-100,-60},{-90,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,60},{98,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-102,-60},{102,-60}},
          color={0,0,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end HydraulicCircuitPartial;

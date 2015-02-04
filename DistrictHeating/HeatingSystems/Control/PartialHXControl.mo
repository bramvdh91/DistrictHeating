within DistrictHeating.HeatingSystems.Control;
partial model PartialHXControl "Partial for HX Control"

  Modelica.Blocks.Interfaces.RealInput senMassFlow2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,40})));
  Modelica.Blocks.Interfaces.RealInput senT2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,80})));
  Modelica.Blocks.Interfaces.RealInput T1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,-40})));
  Modelica.Blocks.Interfaces.RealInput senMassFlow1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,-80})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{-96,-10},{-116,10}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end PartialHXControl;

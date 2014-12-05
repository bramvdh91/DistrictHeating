within DistrictHeating.HeatingSystems.BaseClasses;
partial model PartialHeatExchanger
  "Partial for hydraulic heating system coupled to a district heating system with a heat exchanger"

  extends PartialHeatingSystem;

  HydraulicCircuits.HeatExchanger heatExchanger annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-52})));
  replaceable Control.PartialHXControl partialHXControl
    annotation (Placement(transformation(extent={{-126,-62},{-106,-42}})));
  HydraulicCircuits.ExpansionCircuit direct annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-76})));
equation
  connect(partialHXControl.senMassFlow2, heatExchanger.senMassFlow2)
    annotation (Line(
      points={{-105.6,-44},{-92.6,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.senT2, heatExchanger.senT2) annotation (Line(
      points={{-105.6,-48},{-92.6,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.T1, heatExchanger.senT1) annotation (Line(
      points={{-105.6,-56},{-92.6,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHXControl.senMassFlow1, heatExchanger.senMassFlow1)
    annotation (Line(
      points={{-105.6,-60},{-92.6,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(direct.port_b1, heatExchanger.port_a1) annotation (Line(
      points={{-88,-66},{-88,-62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a2, heatExchanger.port_b2) annotation (Line(
      points={{-76,-66},{-76,-62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_b2, port_b) annotation (Line(
      points={{-76,-86},{-76,-90},{60,-90},{60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(direct.port_a1, port_a) annotation (Line(
      points={{-88,-86},{-88,-100},{-60,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(partialHXControl.y, direct.u) annotation (Line(
      points={{-105.4,-52},{-98,-52},{-98,-76},{-93.4,-76}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHeatExchanger;

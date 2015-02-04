within DistrictHeating.Examples;
model SeriesGrid "District heating grid with buildings connected in series"
  import IDEAS;

  extends Modelica.Icons.Example;

  Interfaces.DHConnection dHConnection(redeclare
      IDEAS.DistrictHeating.Pipes.DoublePipes.TwinPipeGround
      districtHeatingPipe, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-44,8},{-24,24}})));
  Interfaces.BuildingDH building1(
    redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    DH=true,
    redeclare IDEAS.Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.DistrictHeating.HeatingSystems.DirectSh heatingSystem)
    annotation (Placement(transformation(extent={{-44,34},{-24,54}})));
  Modelica.Blocks.Sources.Constant TGround(k=273 + 8)
    annotation (Placement(transformation(extent={{-64,-32},{-44,-12}})));
  IDEAS.Fluid.Sources.FixedBoundary absolutePressure(
                use_T=false,
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-28})));
equation
  connect(building1.flowPortReturnOut,dHConnection. flowPortIn) annotation (
      Line(
      points={{-36,34.2},{-36,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection.flowPortOut,building1. flowPortSupplyIn) annotation (
      Line(
      points={{-32,24},{-32,34.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(TGround.y,dHConnection. TAmbient) annotation (Line(
      points={{-43,-22},{-36,-22},{-36,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHConnection.flowPort_supply_out, dHConnection.flowPort_return_in)
    annotation (Line(
      points={{-44,18},{-48,18},{-48,14},{-44,14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dHConnection.flowPort_supply_in, dHConnection.flowPort_return_out)
    annotation (Line(
      points={{-24,18},{-4,18},{-4,14},{-24,14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(absolutePressure.ports[1], dHConnection.flowPort_return_out)
    annotation (Line(
      points={{6,-18},{6,16},{-4,16},{-4,14},{-24,14}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics));
end SeriesGrid;

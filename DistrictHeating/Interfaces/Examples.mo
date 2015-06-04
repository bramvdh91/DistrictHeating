within DistrictHeating.Interfaces;
package Examples
  model DHNetwork
    DHConnection dHConnection(
      measureSupplyT=true,
      measureReturnT=true,
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=100)
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    DHConnection dHConnection1(
      measureSupplyT=true,
      measureReturnT=true,
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=1000)
      annotation (Placement(transformation(extent={{-10,0},{10,20}})));
    DHConnection dHConnection2(
      measureSupplyT=true,
      measureReturnT=true,
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=10000)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Fluid.Sources.FixedBoundary returnsink(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_T=false,
      T=343.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-68,0},{-60,8}})));
    Modelica.Fluid.Sources.MassFlowSource_T supplySource(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      T=343.15,
      m_flow=0.5,
      nPorts=1)
      annotation (Placement(transformation(extent={{-68,12},{-60,20}})));
    Modelica.Fluid.Sources.MassFlowSource_T returnSource(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow=0.5,
      nPorts=1,
      T=303.15) annotation (Placement(transformation(extent={{68,0},{60,8}})));
    Modelica.Fluid.Sources.FixedBoundary supplySink(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_T=false,
      T=343.15,
      nPorts=1) annotation (Placement(transformation(extent={{68,12},{60,20}})));
  equation
    connect(dHConnection.port_b1, dHConnection1.port_a1) annotation (Line(
        points={{-20,16},{-10,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection.port_a2, dHConnection1.port_b2) annotation (Line(
        points={{-20,4},{-10,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection1.port_b1, dHConnection2.port_a1) annotation (Line(
        points={{10,16},{20,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection1.port_a2, dHConnection2.port_b2) annotation (Line(
        points={{10,4},{20,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection.port_b2, returnsink.ports[1]) annotation (Line(
        points={{-40,4},{-60,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection.port_a1, supplySource.ports[1]) annotation (Line(
        points={{-40,16},{-60,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection2.port_a2, returnSource.ports[1]) annotation (Line(
        points={{40,4},{60,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection2.port_b1, supplySink.ports[1]) annotation (Line(
        points={{40,16},{60,16}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end DHNetwork;
end Examples;

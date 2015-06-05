within DistrictHeating.Interfaces;
package Examples
  model DHNetwork

    DHConnection dHConnection(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=100,
      T_start=273.15 + 60,
      redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe,
      dynamicBalance=true,
      tau=60,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    DHConnection dHConnection1(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=1000,
      T_start=273.15 + 60,
      redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe,
      dynamicBalance=true,
      tau=60,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,0},{10,20}})));
    DHConnection dHConnection2(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      length=10000,
      T_start=273.15 + 60,
      redeclare DistrictHeating.Pipes.DoublePipes.TwinPipeGround
        districtHeatingPipe,
      dynamicBalance=true,
      tau=60,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Annex60.Fluid.HeatExchangers.HeaterCooler_T hea(redeclare package Medium =
          Buildings.Media.Water,
      m_flow_nominal=0.5,
      dp_nominal=20,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-72,6},{-52,26}})));
    Annex60.Fluid.Movers.FlowControlled_m_flow fan(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.5,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
      annotation (Placement(transformation(extent={{50,6},{70,26}})));
    Modelica.Blocks.Sources.Constant const(k=273.15 + 70)
      annotation (Placement(transformation(extent={{-94,40},{-74,60}})));
    Modelica.Blocks.Sources.Constant const1(k=0.5)
      annotation (Placement(transformation(extent={{24,40},{44,60}})));
    Annex60.Fluid.Sources.FixedBoundary bou(
      redeclare package Medium = Buildings.Media.Water,
      use_T=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{-76,-34},{-56,-14}})));
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
    connect(hea.port_b, dHConnection.port_a1) annotation (Line(
        points={{-52,16},{-40,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hea.port_a, dHConnection.port_b2) annotation (Line(
        points={{-72,16},{-78,16},{-78,4},{-40,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection2.port_b1, fan.port_a) annotation (Line(
        points={{40,16},{50,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(dHConnection2.port_a2, fan.port_b) annotation (Line(
        points={{40,4},{74,4},{74,16},{70,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(const1.y, fan.m_flow_in) annotation (Line(
        points={{45,50},{59.8,50},{59.8,28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, hea.TSet) annotation (Line(
        points={{-73,50},{-66,50},{-66,30},{-78,30},{-78,22},{-74,22}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(bou.ports[1], dHConnection.port_a1) annotation (Line(
        points={{-56,-24},{-46,-24},{-46,16},{-40,16}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end DHNetwork;
end Examples;

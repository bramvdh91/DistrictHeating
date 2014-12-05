within DistrictHeating.HeatingSystems;
model IndirectSH
  //Extensions
  extends BaseClasses.PartialHeatExchanger(
    redeclare replaceable package Medium = IDEAS.Media.Water.Simple,
    redeclare IDEAS.Fluid.HeatExchangers.Radiators.Radiator emission(TInNom=
          343.15, TOutNom=323.15),
    pipeSupply(m=1, UA=10),
    pipeReturn(m=1, UA=10),
    redeclare HydraulicCircuits.PumpMassFlow hydraulicCircuitSH(
      m1_flow_nominal=m_flow_zone,
      m2_flow_nominal=m_flow_zone,
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium),
    redeclare Control.Hysteresis controlSH(
      release=false,
      uLow=273.15 + 21,
      uHigh=273.15 + 23,
      realTrue=0,
      realFalse=m_flow_zone),
    heatExchanger(
      redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m_flow_nominal,
      efficiency=0.9,
      m=1,
      dp2_nominal(displayUnit="Pa") = 200,
      dp1_nominal(displayUnit="Pa") = 200,
      p(displayUnit="bar") = 200000),
    redeclare Control.SupplyTControl  partialHXControl,
    direct(m1_flow_nominal=m_flow_nominal, m2_flow_nominal=m_flow_nominal));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nZones](Q_flow=0)
                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-180,60})));

  HydraulicCircuits.Mixer mixer(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal,
    TSup_nominal=323.15,
    TSupMin=313.15,
    TRet_nominal=303.15,
    TRoo_nominal=294.15,
    TOut_nominal=265.15)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-14})));

  IDEAS.Fluid.Sources.FixedBoundary bou(
    use_T=false,
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-110,-14})));

equation
  QHeaSys = -sum(emission.heatPortCon.Q_flow) - sum(emission.heatPortRad.Q_flow);
  P[1] = 0;
  Q[1] = 0;

  connect(fixedHeatFlow.port, heatPortEmb) annotation (Line(
      points={{-190,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, controlSH.u) annotation (Line(
      points={{-204,-60},{-152,-60},{-152,44},{-127.2,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneSplitter.port_a, mixer.port_b1) annotation (Line(
      points={{-88,10.2},{-88,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_b, mixer.port_a2) annotation (Line(
      points={{-76,10},{-76,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet[1], mixer.u) annotation (Line(
      points={{-160,-104},{-160,-66},{-144,-66},{-144,-14},{-93.4,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatExchanger.port_b1, mixer.port_a1) annotation (Line(
      points={{-88,-42},{-88,-24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatExchanger.port_a2, mixer.port_b2) annotation (Line(
      points={{-76,-42},{-76,-24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], mixer.port_a1) annotation (Line(
      points={{-110,-24},{-110,-32},{-88,-32},{-88,-24}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end IndirectSH;

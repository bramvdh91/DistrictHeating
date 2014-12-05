within DistrictHeating.HeatingSystems.HydraulicCircuits;
model Mixer
  //Extensions
  extends BaseClasses.HydraulicCircuitPartial(
    redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
    redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple,
    from_dp=false);

  //Parameters
  parameter Real mcurve=1.3 "Exponent for heat transfer"
    annotation (Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TSup_nominal "Supply temperature"
    annotation (Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30 if minSup
    "Minimum supply temperature if enabled"
    annotation (Dialog(group="Heating curve"));
  parameter Boolean minSup=true
    "true to limit the supply temperature on the lower side"
    annotation (Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TRet_nominal "Return temperature"
    annotation (Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TRoo_nominal=293.15 "Room temperature"
    annotation (Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TOut_nominal "Outside temperature"
    annotation (Dialog(group="Heating curve"));

  parameter Boolean use_TRoo_in=false
    "Get the room temperature set point from the input connector" annotation (
    Evaluate=true,
    HideResult=true,
    choices(__Dymola_checkBox=true),
    Dialog(group="Heating curve"));
  parameter Modelica.SIunits.Temperature TRoo=293.15
    "Fixed value of room air temperature set point"
    annotation (Evaluate=true, Dialog(enable=not use_TRoo_in), Dialog(group="Heating curve"));
  parameter Modelica.SIunits.TemperatureDifference dTOutHeaBal=8
    "Offset for heating curve"
    annotation (Dialog(group="Heating curve"));

  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl(
    redeclare replaceable package Medium = Medium1,
    m_flow_nominal={m1_flow_nominal,m1_flow_nominal,-m1_flow_nominal},
    dp_nominal={-20,20,-20}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={12,-60})));
  IDEAS.Fluid.Valves.Thermostatic3WayValve idealCtrlMixer(redeclare package
      Medium = Medium1, m_flow_nominal=m1_flow_nominal) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={12,6})));
  IDEAS.Controls.ControlHeating.HeatingCurve heatingCurve(
    m=mcurve,
    dTOutHeaBal=dTOutHeaBal,
    use_TRoo_in=use_TRoo_in,
    minSup=minSup,
    TSup_nominal=TSup_nominal,
    TSupMin=TSupMin,
    TRet_nominal=TRet_nominal,
    TOut_nominal=TOut_nominal)
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,48})));
  outer IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,82})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MixT(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{28,-4},{48,16}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort supplyT(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-26,-4},{-6,16}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senReturnT(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{56,-70},{36,-50}})));
  Modelica.Blocks.Interfaces.RealInput u "Control input signal"
                                       annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,114})));
equation
  connect(spl.port_3, idealCtrlMixer.port_a2) annotation (Line(
      points={{12,-50},{12,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingCurve.TOut, realExpression.y) annotation (Line(
      points={{12,60},{12,68},{20,68},{20,71}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(idealCtrlMixer.port_b, MixT.port_a) annotation (Line(
      points={{22,6},{28,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(supplyT.port_b, idealCtrlMixer.port_a1) annotation (Line(
      points={{-6,6},{2,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingCurve.TSup, idealCtrlMixer.TMixedSet) annotation (Line(
      points={{12,37},{12,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MixT.port_b, port_b1) annotation (Line(
      points={{48,6},{60,6},{60,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a2, senReturnT.port_a) annotation (Line(
      points={{100,-60},{56,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senReturnT.port_b, spl.port_1) annotation (Line(
      points={{36,-60},{22,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated2.port_b, supplyT.port_a) annotation (Line(
      points={{-70,60},{-46,60},{-46,6},{-26,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated1.port_a, spl.port_2) annotation (Line(
      points={{-70,-60},{2,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, heatingCurve.TRoo_in) annotation (Line(
      points={{0,114},{0,59.9}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-20,70},{-20,50},{0,60},{-20,70}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={0,50},
          rotation=90),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={10,60},
          rotation=180),
        Line(
          points={{-100,60},{-60,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-60},{94,-60},{100,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{0,40},{0,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{60,60},{90,60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end Mixer;

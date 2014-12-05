within DistrictHeating.Production.HeatSources.Examples;
model Comparison "Test using the function model"
  //Extensions
  extends Modelica.Icons.Example;

  PerformanceMap3D performanceMap3D(
    redeclare package Medium=IDEAS.Media.Water.Simple,
    QNomRef=boiler.QNomRef,
    etaRef=boiler.etaRef,
    modulationStart=boiler.modulationStart,
    QNom=10000,
    UALoss=10,
    space=boiler.space,
    modulationMin=boiler.modulationMin,
    TMax=353.15,
    TMin=293.15)
    annotation (Placement(transformation(extent={{24,32},{44,52}})));
  Polynomial polynomial(
    redeclare package Medium=IDEAS.Media.Water.Simple,
    QNomRef=boiler.QNomRef,
    etaRef=boiler.etaRef,
    modulationMin=boiler.modulationMin,
    modulationStart=boiler.modulationStart,
    QNom=10000,
    UALoss=10,
    beta=boiler2ndDegree.beta,
    powers=boiler2ndDegree.powers,
    TMax=353.15,
    TMin=293.15)
    annotation (Placement(transformation(extent={{26,-14},{46,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=2e5)
    annotation (Placement(transformation(extent={{-70,38},{-50,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=70)
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 60 + 0.05
        *time)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=0.01*time)
    annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
  Data.PerformanceMaps.Boiler boiler
    annotation (Placement(transformation(extent={{24,62},{44,82}})));
  Data.Polynomials.Boiler2ndDegree boiler2ndDegree
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
equation
  connect(realExpression1.y, polynomial.TSet) annotation (Line(
      points={{-49,-10},{25.2,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression1.y, performanceMap3D.TSet) annotation (Line(
      points={{-49,-10},{-16,-10},{-16,36},{23.2,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, performanceMap3D.hIn) annotation (Line(
      points={{-49,48},{23.2,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, polynomial.hIn) annotation (Line(
      points={{-49,48},{0,48},{0,2},{25.2,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression3.y, performanceMap3D.m_flow) annotation (Line(
      points={{-49,28},{-34,28},{-34,44},{23.2,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression3.y, polynomial.m_flow) annotation (Line(
      points={{-49,28},{-34,28},{-34,-2},{25.2,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression2.y, performanceMap3D.THxIn) annotation (Line(
      points={{-49,10},{-8,10},{-8,40},{23.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression2.y, polynomial.THxIn) annotation (Line(
      points={{-49,10},{-8,10},{-8,-6},{25.2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=200),
    __Dymola_experimentSetupOutput);
end Comparison;

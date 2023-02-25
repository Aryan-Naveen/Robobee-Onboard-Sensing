<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="99" name="SpiceOrder" color="7" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="ICM-42688-V">
<description>&lt;High Precision 6-Axis MEMS MotionTracking? Device with Advanced Sensor Fusion Library&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="IIM42352">
<description>&lt;b&gt;14 Lead LGA (2.5x3x0.91)_1&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-1.15" y="0.75" dx="0.6" dy="0.3" layer="1"/>
<smd name="2" x="-1.15" y="0.25" dx="0.6" dy="0.3" layer="1"/>
<smd name="3" x="-1.15" y="-0.25" dx="0.6" dy="0.3" layer="1"/>
<smd name="4" x="-1.15" y="-0.75" dx="0.6" dy="0.3" layer="1"/>
<smd name="5" x="-0.5" y="-0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<smd name="6" x="0" y="-0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<smd name="7" x="0.5" y="-0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<smd name="8" x="1.15" y="-0.75" dx="0.6" dy="0.3" layer="1"/>
<smd name="9" x="1.15" y="-0.25" dx="0.6" dy="0.3" layer="1"/>
<smd name="10" x="1.15" y="0.25" dx="0.6" dy="0.3" layer="1"/>
<smd name="11" x="1.15" y="0.75" dx="0.6" dy="0.3" layer="1"/>
<smd name="12" x="0.5" y="0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<smd name="13" x="0" y="0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<smd name="14" x="-0.5" y="0.9" dx="0.6" dy="0.3" layer="1" rot="R90"/>
<text x="-0.225" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="-0.225" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-1.5" y1="1.25" x2="1.5" y2="1.25" width="0.2" layer="51"/>
<wire x1="1.5" y1="1.25" x2="1.5" y2="-1.25" width="0.2" layer="51"/>
<wire x1="1.5" y1="-1.25" x2="-1.5" y2="-1.25" width="0.2" layer="51"/>
<wire x1="-1.5" y1="-1.25" x2="-1.5" y2="1.25" width="0.2" layer="51"/>
<wire x1="-2.7" y1="2" x2="2.25" y2="2" width="0.1" layer="51"/>
<wire x1="2.25" y1="2" x2="2.25" y2="-2" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2" x2="-2.7" y2="-2" width="0.1" layer="51"/>
<wire x1="-2.7" y1="-2" x2="-2.7" y2="2" width="0.1" layer="51"/>
<wire x1="-1.5" y1="1" x2="-1.5" y2="1.25" width="0.1" layer="21"/>
<wire x1="-1.5" y1="1.25" x2="-0.8" y2="1.25" width="0.1" layer="21"/>
<wire x1="0.8" y1="1.25" x2="1.5" y2="1.25" width="0.1" layer="21"/>
<wire x1="1.5" y1="1.25" x2="1.5" y2="1" width="0.1" layer="21"/>
<wire x1="-1.5" y1="-1.1" x2="-1.5" y2="-1.25" width="0.1" layer="21"/>
<wire x1="-1.5" y1="-1.25" x2="-0.8" y2="-1.25" width="0.1" layer="21"/>
<wire x1="0.8" y1="-1.25" x2="1.5" y2="-1.25" width="0.1" layer="21"/>
<wire x1="1.5" y1="-1.25" x2="1.5" y2="-1" width="0.1" layer="21"/>
<wire x1="-1.9" y1="0.8" x2="-1.9" y2="0.8" width="0.1" layer="21"/>
<wire x1="-1.9" y1="0.8" x2="-1.9" y2="0.7" width="0.1" layer="21" curve="180"/>
<wire x1="-1.9" y1="0.7" x2="-1.9" y2="0.7" width="0.1" layer="21"/>
<wire x1="-1.9" y1="0.7" x2="-1.9" y2="0.8" width="0.1" layer="21" curve="180"/>
</package>
</packages>
<symbols>
<symbol name="ICM-42688-V">
<wire x1="5.08" y1="38.1" x2="60.96" y2="38.1" width="0.254" layer="94"/>
<wire x1="60.96" y1="-20.32" x2="60.96" y2="38.1" width="0.254" layer="94"/>
<wire x1="60.96" y1="-20.32" x2="5.08" y2="-20.32" width="0.254" layer="94"/>
<wire x1="5.08" y1="38.1" x2="5.08" y2="-20.32" width="0.254" layer="94"/>
<text x="62.23" y="43.18" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="62.23" y="40.64" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="AP_SDO_/_AP_AD0" x="0" y="0" length="middle"/>
<pin name="RESV_1" x="0" y="-2.54" length="middle"/>
<pin name="RESV_2" x="0" y="-5.08" length="middle"/>
<pin name="INT1_/_INT" x="0" y="-7.62" length="middle"/>
<pin name="VDDIO" x="30.48" y="-25.4" length="middle" rot="R90"/>
<pin name="GND" x="33.02" y="-25.4" length="middle" rot="R90"/>
<pin name="RESV_3" x="35.56" y="-25.4" length="middle" rot="R90"/>
<pin name="VDD" x="66.04" y="-7.62" length="middle" rot="R180"/>
<pin name="INT2_/_FSYNC_/_CLKIN" x="66.04" y="-5.08" length="middle" rot="R180"/>
<pin name="RESV_4" x="66.04" y="-2.54" length="middle" rot="R180"/>
<pin name="RESV_5" x="66.04" y="0" length="middle" rot="R180"/>
<pin name="AP_CS" x="35.56" y="43.18" length="middle" rot="R270"/>
<pin name="AP_SCL_/_AP_SCLK" x="33.02" y="43.18" length="middle" rot="R270"/>
<pin name="AP_SDA_/_AP_SDIO_/_AP_SDI" x="30.48" y="43.18" length="middle" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="ICM-42688-V" prefix="AC">
<description>&lt;b&gt;High Precision 6-Axis MEMS MotionTracking? Device with Advanced Sensor Fusion Library&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://3cfeqx1hf82y3xcoull08ihx-wpengine.netdna-ssl.com/wp-content/uploads/2021/04/DS-000439-ICM-42688-V-v1.1.pdf"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="ICM-42688-V" x="0" y="0"/>
</gates>
<devices>
<device name="" package="IIM42352">
<connects>
<connect gate="G$1" pin="AP_CS" pad="12"/>
<connect gate="G$1" pin="AP_SCL_/_AP_SCLK" pad="13"/>
<connect gate="G$1" pin="AP_SDA_/_AP_SDIO_/_AP_SDI" pad="14"/>
<connect gate="G$1" pin="AP_SDO_/_AP_AD0" pad="1"/>
<connect gate="G$1" pin="GND" pad="6"/>
<connect gate="G$1" pin="INT1_/_INT" pad="4"/>
<connect gate="G$1" pin="INT2_/_FSYNC_/_CLKIN" pad="9"/>
<connect gate="G$1" pin="RESV_1" pad="2"/>
<connect gate="G$1" pin="RESV_2" pad="3"/>
<connect gate="G$1" pin="RESV_3" pad="7"/>
<connect gate="G$1" pin="RESV_4" pad="10"/>
<connect gate="G$1" pin="RESV_5" pad="11"/>
<connect gate="G$1" pin="VDD" pad="8"/>
<connect gate="G$1" pin="VDDIO" pad="5"/>
</connects>
<technologies>
<technology name="">
<attribute name="ARROW_PART_NUMBER" value="" constant="no"/>
<attribute name="ARROW_PRICE-STOCK" value="" constant="no"/>
<attribute name="DESCRIPTION" value="High Precision 6-Axis MEMS MotionTracking? Device with Advanced Sensor Fusion Library" constant="no"/>
<attribute name="HEIGHT" value="mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="TDK" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="ICM-42688-V" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="410-ICM-42688-V" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="https://www.mouser.co.uk/ProductDetail/TDK-InvenSense/ICM-42688-V?qs=iLbezkQI%252Bsj8X%2F1CCh43jQ%3D%3D" constant="no"/>
<attribute name="MOUSER_TESTING_PART_NUMBER" value="" constant="no"/>
<attribute name="MOUSER_TESTING_PRICE-STOCK" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1" urn="urn:adsk.eagle:library:371">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
 GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
 Please keep in mind, that these devices are necessary for the
 automatic wiring of the supply signals.&lt;p&gt;
 The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
 In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="+3V3" urn="urn:adsk.eagle:symbol:26950/1" library_version="1">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="+3V3" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
<symbol name="GND" urn="urn:adsk.eagle:symbol:26925/1" library_version="1">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="+3V3" urn="urn:adsk.eagle:component:26981/1" prefix="+3V3" library_version="1">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="+3V3" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="GND" urn="urn:adsk.eagle:component:26954/1" prefix="GND" library_version="1">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Capacitor_0201_0.1">
<description>&lt;Multilayer Ceramic Capacitors MLCC - SMD/SMT&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="CAPC0201X14N">
<description>&lt;b&gt;008004 (0201 Metric)&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-0.245" y="0" dx="0.29" dy="0.26" layer="1"/>
<smd name="2" x="0.245" y="0" dx="0.29" dy="0.26" layer="1"/>
<text x="0" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="0" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-0.54" y1="0.28" x2="0.54" y2="0.28" width="0.05" layer="51"/>
<wire x1="0.54" y1="0.28" x2="0.54" y2="-0.28" width="0.05" layer="51"/>
<wire x1="0.54" y1="-0.28" x2="-0.54" y2="-0.28" width="0.05" layer="51"/>
<wire x1="-0.54" y1="-0.28" x2="-0.54" y2="0.28" width="0.05" layer="51"/>
<wire x1="-0.125" y1="0.062" x2="0.125" y2="0.062" width="0.1" layer="51"/>
<wire x1="0.125" y1="0.062" x2="0.125" y2="-0.062" width="0.1" layer="51"/>
<wire x1="0.125" y1="-0.062" x2="-0.125" y2="-0.062" width="0.1" layer="51"/>
<wire x1="-0.125" y1="-0.062" x2="-0.125" y2="0.062" width="0.1" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="GRM011R60J104ME01L">
<wire x1="5.588" y1="2.54" x2="5.588" y2="-2.54" width="0.254" layer="94"/>
<wire x1="7.112" y1="2.54" x2="7.112" y2="-2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="0" x2="5.588" y2="0" width="0.254" layer="94"/>
<wire x1="7.112" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<text x="8.89" y="6.35" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="8.89" y="3.81" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="1" x="0" y="0" visible="pad" length="middle"/>
<pin name="2" x="12.7" y="0" visible="pad" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GRM011R60J104ME01L" prefix="C">
<description>&lt;b&gt;Multilayer Ceramic Capacitors MLCC - SMD/SMT&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://www.murata.com/en-eu/api/pdfdownloadapi?cate=luCeramicCapacitorsSMD&amp;partno=GRM011R60J104ME01#"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="GRM011R60J104ME01L" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CAPC0201X14N">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="DESCRIPTION" value="Multilayer Ceramic Capacitors MLCC - SMD/SMT" constant="no"/>
<attribute name="HEIGHT" value="0.138mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Murata Electronics" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="GRM011R60J104ME01L" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="81-GRM011R60J104ME1L" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="https://www.mouser.co.uk/ProductDetail/Murata-Electronics/GRM011R60J104ME01L?qs=hd1VzrDQEGgrOiW%2FuBfgqw%3D%3D" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Capacitor_0201_0.001">
<description>&lt;Capacitor GRM01 L=0.25mm W=0.125mm T=0.125mm&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="CAPC0201X14N">
<description>&lt;b&gt;GRM01 L=0.25mm W=0.125mm T=0.125mm&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-0.245" y="0" dx="0.29" dy="0.26" layer="1"/>
<smd name="2" x="0.245" y="0" dx="0.29" dy="0.26" layer="1"/>
<text x="0" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="0" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-0.54" y1="0.28" x2="0.54" y2="0.28" width="0.05" layer="51"/>
<wire x1="0.54" y1="0.28" x2="0.54" y2="-0.28" width="0.05" layer="51"/>
<wire x1="0.54" y1="-0.28" x2="-0.54" y2="-0.28" width="0.05" layer="51"/>
<wire x1="-0.54" y1="-0.28" x2="-0.54" y2="0.28" width="0.05" layer="51"/>
<wire x1="-0.125" y1="0.062" x2="0.125" y2="0.062" width="0.1" layer="51"/>
<wire x1="0.125" y1="0.062" x2="0.125" y2="-0.062" width="0.1" layer="51"/>
<wire x1="0.125" y1="-0.062" x2="-0.125" y2="-0.062" width="0.1" layer="51"/>
<wire x1="-0.125" y1="-0.062" x2="-0.125" y2="0.062" width="0.1" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="GRM011R60J103KE01L">
<wire x1="5.588" y1="2.54" x2="5.588" y2="-2.54" width="0.254" layer="94"/>
<wire x1="7.112" y1="2.54" x2="7.112" y2="-2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="0" x2="5.588" y2="0" width="0.254" layer="94"/>
<wire x1="7.112" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<text x="8.89" y="6.35" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="8.89" y="3.81" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="1" x="0" y="0" visible="pad" length="middle"/>
<pin name="2" x="12.7" y="0" visible="pad" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GRM011R60J103KE01L" prefix="C">
<description>&lt;b&gt;Capacitor GRM01 L=0.25mm W=0.125mm T=0.125mm&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://psearch.en.murata.com/capacitor/product/GRM011R60J103KE01#.html"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="GRM011R60J103KE01L" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CAPC0201X14N">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="DESCRIPTION" value="Capacitor GRM01 L=0.25mm W=0.125mm T=0.125mm" constant="no"/>
<attribute name="HEIGHT" value="0.138mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Murata Electronics" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="GRM011R60J103KE01L" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Capacitor_0603_2.2_v2">
<description>&lt;Multilayer Ceramic Capacitors MLCC - SMD/SMT 0201 2.2uF 6.3volts *Derate Voltage/Temp&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="CAPC0603X33N">
<description>&lt;b&gt;GRM03_0.03 L=0.6mm W=0.3mm T=0.3mm&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-0.33" y="0" dx="0.46" dy="0.42" layer="1"/>
<smd name="2" x="0.33" y="0" dx="0.46" dy="0.42" layer="1"/>
<text x="0" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="0" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-0.71" y1="0.36" x2="0.71" y2="0.36" width="0.05" layer="51"/>
<wire x1="0.71" y1="0.36" x2="0.71" y2="-0.36" width="0.05" layer="51"/>
<wire x1="0.71" y1="-0.36" x2="-0.71" y2="-0.36" width="0.05" layer="51"/>
<wire x1="-0.71" y1="-0.36" x2="-0.71" y2="0.36" width="0.05" layer="51"/>
<wire x1="-0.3" y1="0.15" x2="0.3" y2="0.15" width="0.1" layer="51"/>
<wire x1="0.3" y1="0.15" x2="0.3" y2="-0.15" width="0.1" layer="51"/>
<wire x1="0.3" y1="-0.15" x2="-0.3" y2="-0.15" width="0.1" layer="51"/>
<wire x1="-0.3" y1="-0.15" x2="-0.3" y2="0.15" width="0.1" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="GRM033R60J225ME15D">
<wire x1="5.588" y1="2.54" x2="5.588" y2="-2.54" width="0.254" layer="94"/>
<wire x1="7.112" y1="2.54" x2="7.112" y2="-2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="0" x2="5.588" y2="0" width="0.254" layer="94"/>
<wire x1="7.112" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<text x="8.89" y="6.35" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="8.89" y="3.81" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="1" x="0" y="0" visible="pad" length="middle"/>
<pin name="2" x="12.7" y="0" visible="pad" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GRM033R60J225ME15D" prefix="C">
<description>&lt;b&gt;Multilayer Ceramic Capacitors MLCC - SMD/SMT 0201 2.2uF 6.3volts *Derate Voltage/Temp&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://datasheet.datasheetarchive.com/originals/distributors/DKDS42/DSANUWW0047682.pdf"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="GRM033R60J225ME15D" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CAPC0603X33N">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="DESCRIPTION" value="Multilayer Ceramic Capacitors MLCC - SMD/SMT 0201 2.2uF 6.3volts *Derate Voltage/Temp" constant="no"/>
<attribute name="HEIGHT" value="0.33mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Murata Electronics" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="GRM033R60J225ME15D" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="81-GRM033R60J225ME5D" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="https://www.mouser.co.uk/ProductDetail/Murata-Electronics/GRM033R60J225ME15D?qs=F5vmRhUsTTp8%2FHfTnu24UA%3D%3D" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="wirepad" urn="urn:adsk.eagle:library:412">
<description>&lt;b&gt;Single Pads&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SMD1,27-2,54" urn="urn:adsk.eagle:footprint:30822/1" library_version="2">
<description>&lt;b&gt;SMD PAD&lt;/b&gt;</description>
<smd name="1" x="0" y="0" dx="1.27" dy="2.54" layer="1"/>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-0.8" y="-2.4" size="1.27" layer="25" rot="R90">&gt;NAME</text>
</package>
</packages>
<packages3d>
<package3d name="SMD1,27-2,54" urn="urn:adsk.eagle:package:30839/1" type="box" library_version="2">
<description>SMD PAD</description>
<packageinstances>
<packageinstance name="SMD1,27-2,54"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="PAD" urn="urn:adsk.eagle:symbol:30808/1" library_version="2">
<wire x1="-1.016" y1="1.016" x2="1.016" y2="-1.016" width="0.254" layer="94"/>
<wire x1="-1.016" y1="-1.016" x2="1.016" y2="1.016" width="0.254" layer="94"/>
<text x="-1.143" y="1.8542" size="1.778" layer="95">&gt;NAME</text>
<text x="-1.143" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="P" x="2.54" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SMD2" urn="urn:adsk.eagle:component:30857/2" prefix="PAD" uservalue="yes" library_version="2">
<description>&lt;b&gt;SMD PAD&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="PAD" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SMD1,27-2,54">
<connects>
<connect gate="1" pin="P" pad="1"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:30839/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="15" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="CH101">
<description>&lt;Ultrasonic ToF (Time-of-Flight) Sensors, Operating Range=4cm to 1.2m, Current Consumption=13?A (1 sample/sec:10cm max range)&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="CH101">
<description>&lt;b&gt;CH101&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-1.425" y="1.2" dx="0.45" dy="0.4" layer="1"/>
<smd name="2" x="-1.425" y="0.4" dx="0.45" dy="0.4" layer="1"/>
<smd name="3" x="-1.425" y="-0.4" dx="0.45" dy="0.4" layer="1"/>
<smd name="4" x="-1.425" y="-1.2" dx="0.45" dy="0.4" layer="1"/>
<smd name="5" x="1.425" y="-1.2" dx="0.45" dy="0.4" layer="1"/>
<smd name="6" x="1.425" y="-0.4" dx="0.45" dy="0.4" layer="1"/>
<smd name="7" x="1.425" y="0.4" dx="0.45" dy="0.4" layer="1"/>
<smd name="8" x="1.425" y="1.2" dx="0.45" dy="0.4" layer="1"/>
<text x="0" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="0" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-1.75" y1="1.75" x2="1.75" y2="1.75" width="0.1" layer="51"/>
<wire x1="1.75" y1="1.75" x2="1.75" y2="-1.75" width="0.1" layer="51"/>
<wire x1="1.75" y1="-1.75" x2="-1.75" y2="-1.75" width="0.1" layer="51"/>
<wire x1="-1.75" y1="-1.75" x2="-1.75" y2="1.75" width="0.1" layer="51"/>
<wire x1="-2.75" y1="2.75" x2="2.75" y2="2.75" width="0.1" layer="51"/>
<wire x1="2.75" y1="2.75" x2="2.75" y2="-2.75" width="0.1" layer="51"/>
<wire x1="2.75" y1="-2.75" x2="-2.75" y2="-2.75" width="0.1" layer="51"/>
<wire x1="-2.75" y1="-2.75" x2="-2.75" y2="2.75" width="0.1" layer="51"/>
<wire x1="-1.75" y1="1.75" x2="1.75" y2="1.75" width="0.2" layer="21"/>
<wire x1="-1.75" y1="-1.75" x2="1.75" y2="-1.75" width="0.2" layer="21"/>
<wire x1="-2.3" y1="1.3" x2="-2.3" y2="1.3" width="0.2" layer="21"/>
<wire x1="-2.3" y1="1.3" x2="-2.3" y2="1.1" width="0.2" layer="21" curve="180"/>
<wire x1="-2.3" y1="1.1" x2="-2.3" y2="1.1" width="0.2" layer="21"/>
<wire x1="-2.3" y1="1.1" x2="-2.3" y2="1.3" width="0.2" layer="21" curve="180"/>
</package>
</packages>
<symbols>
<symbol name="CH101">
<wire x1="5.08" y1="2.54" x2="27.94" y2="2.54" width="0.254" layer="94"/>
<wire x1="27.94" y1="-10.16" x2="27.94" y2="2.54" width="0.254" layer="94"/>
<wire x1="27.94" y1="-10.16" x2="5.08" y2="-10.16" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="5.08" y2="-10.16" width="0.254" layer="94"/>
<text x="29.21" y="7.62" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="29.21" y="5.08" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="INT" x="0" y="0" length="middle"/>
<pin name="SCL" x="0" y="-2.54" length="middle"/>
<pin name="SDA" x="0" y="-5.08" length="middle"/>
<pin name="PROG" x="0" y="-7.62" length="middle"/>
<pin name="VSS" x="33.02" y="-7.62" length="middle" rot="R180"/>
<pin name="VDD" x="33.02" y="-5.08" length="middle" rot="R180"/>
<pin name="AVDD" x="33.02" y="-2.54" length="middle" rot="R180"/>
<pin name="RESET_N" x="33.02" y="0" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="CH101" prefix="IC">
<description>&lt;b&gt;Ultrasonic ToF (Time-of-Flight) Sensors, Operating Range=4cm to 1.2m, Current Consumption=13?A (1 sample/sec:10cm max range)&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://3cfeqx1hf82y3xcoull08ihx-wpengine.netdna-ssl.com/wp-content/uploads/2021/01/DS-000331-CH101-v1.4.pdf"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="CH101" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CH101">
<connects>
<connect gate="G$1" pin="AVDD" pad="7"/>
<connect gate="G$1" pin="INT" pad="1"/>
<connect gate="G$1" pin="PROG" pad="4"/>
<connect gate="G$1" pin="RESET_N" pad="8"/>
<connect gate="G$1" pin="SCL" pad="2"/>
<connect gate="G$1" pin="SDA" pad="3"/>
<connect gate="G$1" pin="VDD" pad="6"/>
<connect gate="G$1" pin="VSS" pad="5"/>
</connects>
<technologies>
<technology name="">
<attribute name="ARROW_PART_NUMBER" value="" constant="no"/>
<attribute name="ARROW_PRICE-STOCK" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Ultrasonic ToF (Time-of-Flight) Sensors, Operating Range=4cm to 1.2m, Current Consumption=13?A (1 sample/sec:10cm max range)" constant="no"/>
<attribute name="HEIGHT" value="1.36mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="TDK" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="CH101" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="AC1" library="ICM-42688-V" deviceset="ICM-42688-V" device=""/>
<part name="+3V1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="+3V3" device=""/>
<part name="GND1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND2" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND3" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND4" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C1" library="Capacitor_0201_0.1" deviceset="GRM011R60J104ME01L" device=""/>
<part name="C3" library="Capacitor_0201_0.001" deviceset="GRM011R60J103KE01L" device=""/>
<part name="C2" library="Capacitor_0603_2.2_v2" deviceset="GRM033R60J225ME15D" device=""/>
<part name="PAD1" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD2" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD3" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="GND5" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="PAD4" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="IC1" library="CH101" deviceset="CH101" device=""/>
<part name="GND6" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="+3V2" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="+3V3" device=""/>
<part name="C4" library="Capacitor_0201_0.1" deviceset="GRM011R60J104ME01L" device=""/>
<part name="GND7" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="AC1" gate="G$1" x="25.4" y="38.1" smashed="yes">
<attribute name="NAME" x="87.63" y="81.28" size="1.778" layer="95" align="center-left"/>
<attribute name="VALUE" x="87.63" y="78.74" size="1.778" layer="96" align="center-left"/>
</instance>
<instance part="+3V1" gate="G$1" x="111.76" y="30.48" smashed="yes" rot="R90">
<attribute name="VALUE" x="116.84" y="27.94" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND1" gate="1" x="55.88" y="-10.16" smashed="yes">
<attribute name="VALUE" x="53.34" y="-12.7" size="1.778" layer="96"/>
</instance>
<instance part="GND2" gate="1" x="96.52" y="12.7" smashed="yes">
<attribute name="VALUE" x="93.98" y="10.16" size="1.778" layer="96"/>
</instance>
<instance part="GND3" gate="1" x="106.68" y="12.7" smashed="yes">
<attribute name="VALUE" x="104.14" y="10.16" size="1.778" layer="96"/>
</instance>
<instance part="GND4" gate="1" x="116.84" y="5.08" smashed="yes" rot="R90">
<attribute name="VALUE" x="119.38" y="2.54" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C1" gate="G$1" x="96.52" y="15.24" smashed="yes" rot="R90">
<attribute name="NAME" x="90.17" y="24.13" size="1.778" layer="95" rot="R90" align="center-left"/>
<attribute name="VALUE" x="92.71" y="24.13" size="1.778" layer="96" rot="R90" align="center-left"/>
</instance>
<instance part="C3" gate="G$1" x="55.88" y="-5.08" smashed="yes" rot="R90">
<attribute name="NAME" x="49.53" y="3.81" size="1.778" layer="95" rot="R90" align="center-left"/>
<attribute name="VALUE" x="52.07" y="3.81" size="1.778" layer="96" rot="R90" align="center-left"/>
</instance>
<instance part="C2" gate="G$1" x="106.68" y="15.24" smashed="yes" rot="R90">
<attribute name="NAME" x="100.33" y="24.13" size="1.778" layer="95" rot="R90" align="center-left"/>
<attribute name="VALUE" x="102.87" y="24.13" size="1.778" layer="96" rot="R90" align="center-left"/>
</instance>
<instance part="PAD1" gate="1" x="55.88" y="99.06" smashed="yes" rot="R270">
<attribute name="NAME" x="57.7342" y="100.203" size="1.778" layer="95" rot="R270"/>
<attribute name="VALUE" x="52.578" y="100.203" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="PAD2" gate="1" x="58.42" y="101.6" smashed="yes" rot="R270">
<attribute name="NAME" x="60.2742" y="102.743" size="1.778" layer="95" rot="R270"/>
<attribute name="VALUE" x="55.118" y="102.743" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="PAD3" gate="1" x="121.92" y="73.66" smashed="yes">
<attribute name="NAME" x="120.777" y="75.5142" size="1.778" layer="95"/>
<attribute name="VALUE" x="120.777" y="70.358" size="1.778" layer="96"/>
</instance>
<instance part="GND5" gate="1" x="127" y="73.66" smashed="yes" rot="R90">
<attribute name="VALUE" x="129.54" y="71.12" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="PAD4" gate="1" x="116.84" y="30.48" smashed="yes" rot="R180">
<attribute name="NAME" x="117.983" y="28.6258" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="117.983" y="33.782" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="IC1" gate="G$1" x="71.12" y="99.06" smashed="yes">
<attribute name="NAME" x="100.33" y="106.68" size="1.778" layer="95" align="center-left"/>
<attribute name="VALUE" x="100.33" y="104.14" size="1.778" layer="96" align="center-left"/>
</instance>
<instance part="GND6" gate="1" x="111.76" y="91.44" smashed="yes" rot="R90">
<attribute name="VALUE" x="114.3" y="88.9" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="+3V2" gate="G$1" x="116.84" y="93.98" smashed="yes" rot="R90">
<attribute name="VALUE" x="121.92" y="91.44" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="C4" gate="G$1" x="114.3" y="93.98" smashed="yes" rot="R90">
<attribute name="NAME" x="107.95" y="102.87" size="1.778" layer="95" rot="R90" align="center-left"/>
<attribute name="VALUE" x="110.49" y="102.87" size="1.778" layer="96" rot="R90" align="center-left"/>
</instance>
<instance part="GND7" gate="1" x="114.3" y="111.76" smashed="yes" rot="R180">
<attribute name="VALUE" x="116.84" y="114.3" size="1.778" layer="96" rot="R180"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="AC1" gate="G$1" pin="AP_SDA_/_AP_SDIO_/_AP_SDI"/>
<pinref part="PAD1" gate="1" pin="P"/>
<wire x1="55.88" y1="96.52" x2="55.88" y2="93.98" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="SDA"/>
<wire x1="55.88" y1="93.98" x2="55.88" y2="81.28" width="0.1524" layer="91"/>
<wire x1="71.12" y1="93.98" x2="55.88" y2="93.98" width="0.1524" layer="91"/>
<junction x="55.88" y="93.98"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="AC1" gate="G$1" pin="AP_SCL_/_AP_SCLK"/>
<pinref part="PAD2" gate="1" pin="P"/>
<pinref part="IC1" gate="G$1" pin="SCL"/>
<wire x1="58.42" y1="96.52" x2="58.42" y2="81.28" width="0.1524" layer="91"/>
<wire x1="58.42" y1="99.06" x2="58.42" y2="96.52" width="0.1524" layer="91"/>
<wire x1="58.42" y1="96.52" x2="71.12" y2="96.52" width="0.1524" layer="91"/>
<junction x="58.42" y="96.52"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="AC1" gate="G$1" pin="GND"/>
<wire x1="58.42" y1="12.7" x2="58.42" y2="5.08" width="0.1524" layer="91"/>
<wire x1="58.42" y1="5.08" x2="114.3" y2="5.08" width="0.1524" layer="91"/>
<pinref part="GND4" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C1" gate="G$1" pin="1"/>
<pinref part="GND2" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="GND3" gate="1" pin="GND"/>
<pinref part="C2" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="GND5" gate="1" pin="GND"/>
<pinref part="PAD3" gate="1" pin="P"/>
</segment>
<segment>
<pinref part="C3" gate="G$1" pin="1"/>
<pinref part="GND1" gate="1" pin="GND"/>
<wire x1="55.88" y1="-5.08" x2="55.88" y2="-7.62" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="IC1" gate="G$1" pin="VSS"/>
<pinref part="GND6" gate="1" pin="GND"/>
<wire x1="104.14" y1="91.44" x2="109.22" y2="91.44" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="GND7" gate="1" pin="GND"/>
<pinref part="C4" gate="G$1" pin="2"/>
<wire x1="114.3" y1="109.22" x2="114.3" y2="106.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3" class="0">
<segment>
<pinref part="+3V1" gate="G$1" pin="+3V3"/>
<pinref part="PAD4" gate="1" pin="P"/>
</segment>
<segment>
<pinref part="IC1" gate="G$1" pin="VDD"/>
<pinref part="+3V2" gate="G$1" pin="+3V3"/>
<wire x1="104.14" y1="93.98" x2="114.3" y2="93.98" width="0.1524" layer="91"/>
<pinref part="C4" gate="G$1" pin="1"/>
<wire x1="114.3" y1="93.98" x2="119.38" y2="93.98" width="0.1524" layer="91"/>
<junction x="114.3" y="93.98"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="AC1" gate="G$1" pin="VDDIO"/>
<wire x1="55.88" y1="12.7" x2="55.88" y2="7.62" width="0.1524" layer="91"/>
<pinref part="C3" gate="G$1" pin="2"/>
<junction x="55.88" y="7.62"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="AC1" gate="G$1" pin="VDD"/>
<pinref part="C2" gate="G$1" pin="2"/>
<wire x1="106.68" y1="27.94" x2="106.68" y2="30.48" width="0.1524" layer="91"/>
<junction x="106.68" y="30.48"/>
<wire x1="106.68" y1="30.48" x2="111.76" y2="30.48" width="0.1524" layer="91"/>
<wire x1="106.68" y1="30.48" x2="96.52" y2="30.48" width="0.1524" layer="91"/>
<pinref part="C1" gate="G$1" pin="2"/>
<wire x1="96.52" y1="27.94" x2="96.52" y2="30.48" width="0.1524" layer="91"/>
<junction x="96.52" y="30.48"/>
<wire x1="96.52" y1="30.48" x2="91.44" y2="30.48" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>

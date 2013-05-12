<?php
	/**
	 * CREATE XML FILE FROM FOLDER CONTENT
	 * Copyright (C) 2010  Constantin Boiangiu  (http://www.php-help.ro)
	 * 
	 * This program is free software: you can redistribute it and/or modify
	 * it under the terms of the GNU General Public License as published by
	 * the Free Software Foundation, either version 3 of the License, or
	 * (at your option) any later version.
	 * 
	 * This program is distributed in the hope that it will be useful,
	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	 * GNU General Public License for more details.
	 * 
	 * You should have received a copy of the GNU General Public License
	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
	 **/
	
	/**
	 * Downloaded from php-help.ro
	 * You can use this script in any way you like without asking for my permission.
	 * For any problems please visit http://www.php-help.ro/php/output-folder-content-in-xml-file/
	 * and leave a comment and I'll answer your question.
	 */
//$path_to_image_dir = 'images/tiles/png'; // relative path to your image directory
$xml_string = <<<XML
<?xml version="1.0" encoding="UTF-8"?>
<root>
</root>
XML;
set_time_limit(60);
$xml_generator = new SimpleXMLElement($xml_string);
	$db 	= new PDO("sqlite:data/hd_colorprofile_hsv.db");
	$sql 	= "SELECT * from swatches";
    $sql	.= " WHERE file like '".$_GET["texture_id"].".%'";
    $sql	.= " order by file;";
    //echo "sql = ".$sql;
	$result = $db->query($sql); 
	foreach ($result as $row) { 
		$swatch = $xml_generator->addChild('swatch');
		$swatch->addChild('id', $row['id']);
		$swatch->addChild('file', $row['file']);
        
        $colors	= $swatch->addChild('colors');

        $sqlColor		= "select distinct(colors_hsv.hsv) as hsv, hsv.rgb as rgb, sum(colors_hsv.count)*100 as percent from colors_hsv, hsv where colors_hsv.hsv = hsv.hsv and colors_hsv.swatch_id=".$row['id']." group by colors_hsv.hsv order by percent desc limit 1;";

		$resultColor	= $db->query($sqlColor);
    	//echo "sqlColor = ".$sqlColor;
        foreach($resultColor as $rowColor)
        {
            $color	= $colors->addChild('color');
        	$color->addChild('code', $rowColor['rgb']);
	       	$color->addChild('hsv', $rowColor['hsv']);
			$color->addChild('percent', $rowColor['percent']);
        }
        
	} 
     

	$db	= NULL;
    $db2	= NULL;
	header("Content-Type: text/xml");
	echo $xml_generator->asXML();
?>
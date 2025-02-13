<?php

$iniFile = parse_ini_file("dbi.ini");

$dbhost = $iniFile["dbhost"];
$dbuser = $iniFile["dbuser"];
$dbpass = $iniFile["dbpass"];
$dbname = $iniFile["dbname"];

session_start();

$con = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
if ($con->connect_errno) {
    echo "Failed to connect to MySQL: " . $con->connect_error;
    exit();
}

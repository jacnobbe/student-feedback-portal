<!DOCTYPE html>
<!--
  view_survey.php
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title> sfp || course survey</title>
  <script type="text/JavaScript" src="js/forms.js"></script>
  <style>.error {color: #FF0000;}</style>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<?php include("header.php"); ?>
<div class="container-fluid">
  <form>
    <?php include_once 'includes/db_functions.php';
          include_once 'includes/view_course.inc.php';?>
    <h2><?php echo $courseID . " // " . $courseName;?> </h2>
    <label>Department</label>  <?php echo $departmentName;?><br/>
    <input type="hidden" name="courseID" value="<?php echo $courseID;?>" />
    <input type="hidden" name="courseName" value="<?php echo $courseName;?>" />

    <input type="hidden" name="ref" value="<?php echo $ref;?>" />

    <label>Course Survey</label>
    <?php include_once 'includes/disp_survey.inc.php';?>
  </form>
</div>
</body>
</html>
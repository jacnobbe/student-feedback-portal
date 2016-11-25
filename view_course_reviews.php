<!DOCTYPE html>
<!--
  view_student.php
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>sfp || view course reviews</title>
  <script type="text/JavaScript" src="js/forms.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
  <?php include("header.php"); ?>
  <div class="container-fluid">
  <form>
    <?php include_once 'includes/db_functions.php';
          include_once 'includes/view_course_reviews.inc.php';?>

    <h2><?php echo $courseID . " " . $courseName; ?></h2>
    <label>Taught by</label>  <?php echo $professorFName . " " . $professorLName;?><br/>
    <input type="hidden" name="professorID" value="<?php echo $professorID;?>" />
    <input type="hidden" name="ref" value="<?php echo $ref;?>" />

    <h3>Other Courses Taught By This Professor</h3>
    <?php include_once 'includes/disp_reviews.inc.php';?>

  </form>

</div>
</body>
</html>
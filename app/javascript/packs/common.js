// Date picker for User Profile edit
// $( function() {
//   $( "#datepicker, #to_date" ).datepicker({  
//     dateFormat: 'yy/mm/dd'
//   });
// });

// Data Table for Both User and Post 
var dataTable = null

document.addEventListener("turbolinks:before-cache", function() {
  if (dataTable !== null) {
  dataTable.destroy()
  dataTable = null
  }
})

$(document).ready( function () {
  dataTable = $('#table_id').DataTable({
        "searching": false,
        "ordering": false,
        "bLengthChange": false,
        "info": false,
        "pageLength": 5,
        responsive: true
    })
});
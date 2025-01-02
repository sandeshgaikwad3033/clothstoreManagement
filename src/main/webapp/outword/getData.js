/**
 * 
 */
$(document).ready(function(){  	
	$("#employee").change(function() {    
		var id = $(this).find(":selected").val();
		var dataString = 'productId='+ id;    
		$.ajax({
			url: '../Inword_data_ajax',
			dataType: "json",
			data: dataString,  
			cache: false,
			success: function(empData) {
			   if(empData) {
					$("#errorMassage").addClass('hidden').text("");
					$("#recordListing").removeClass('hidden');							
					$("#productId").text(empData.product_code);
					$("#productName").text(empData.product_name);
					$("#basePrice").text(empData.base_price);
					$("#seilingPrice").text("$"+empData.seiling_price);					
				} else {
					$("#recordListing").addClass('hidden');	
					$("#errorMassage").removeClass('hidden').text("No record found!");
				}   	
			} 
		});
 	}) 
});

<?php header('Access-Control-Allow-Origin: *'); ?>

<?php
    if(isset($_GET['search'])){
        $query = $_GET['search'];
        $type = $_GET['type'];
        $center = $_GET['center'];
        $distance = $_GET['distance'];
        if($type != 'place'){
	    	$query = urlencode($query);
	        $url = "https://graph.facebook.com/v2.8/search?q=$query&type=$type&fields=id,name,picture.width(700).height(700)&limit=10&access_token=EAADyNHdNlhkBAFcfMPOvgwkSqZChMj2jCZAAuQyvru4oHce9hxwVJ0AYcNoLzvkRXNMaXhXLZAEICVyVmPvdaNsNyOVKm9GhIwXZAeSEShzDvoQoF8o1TllIlbpbAdM2r1dcPThUpmp7mOBkPCLud4UVb6GaS7kZD";
	        echo file_get_contents($url);
	    }else{
	        $query = urlencode($query);
	        $url = "https://graph.facebook.com/v2.8/search?q=$query&type=$type&fields=id,name,picture.width(700).height(700)&limit=10&center=$center&access_token=EAADyNHdNlhkBAFcfMPOvgwkSqZChMj2jCZAAuQyvru4oHce9hxwVJ0AYcNoLzvkRXNMaXhXLZAEICVyVmPvdaNsNyOVKm9GhIwXZAeSEShzDvoQoF8o1TllIlbpbAdM2r1dcPThUpmp7mOBkPCLud4UVb6GaS7kZD";
	        echo file_get_contents($url);
	    }
    }else{
    	$id = $_GET['id'];
        $id = urlencode($id);
        $url = "https://graph.facebook.com/v2.8/$id?fields=id,name,picture.width(700).height(700),albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5)&access_token=EAADyNHdNlhkBAFcfMPOvgwkSqZChMj2jCZAAuQyvru4oHce9hxwVJ0AYcNoLzvkRXNMaXhXLZAEICVyVmPvdaNsNyOVKm9GhIwXZAeSEShzDvoQoF8o1TllIlbpbAdM2r1dcPThUpmp7mOBkPCLud4UVb6GaS7kZD";
	    echo file_get_contents($url);
    }
?>
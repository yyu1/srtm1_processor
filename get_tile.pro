;Reads a given tile from disk and returns the array of data
;If tile file does not exist, return an array of 0
;argument passed in is the lower left corner of the tile in integer degrees

Function get_tile, longitude, latitude, tile_dir

	if (longitude lt -180) or (longitude gt 179) or (latitude lt -90) or (latitude gt 89) then message, 'Longitude Latitude out of bounds.', longitude, latitude

	longitude = fix(longitude)
	latitude = fix(latitude)

	;Setting
	;tile_dir = '/nobackupp6/nexprojects/CMS-ALOS/srtm'


	file_name = ''
	if (latitude ge 0) then file_name += 'N' + strtrim(string(latitude,format='(i02)'),2) else file_name += 'S' + strtrim(string(-latitude,format='(i02)'),2)
	if (longitude ge 0) then file_name += 'E' + strtrim(string(longitude,format='(i03)'),2) else file_name += 'W' + strtrim(string(-longitude,format='(i03)'),2)
	file_name = tile_dir + '/' + file_name + '.hgt'


	tile_data = intarr(3601,3601)

	;test if file exists
	if file_test(file_name) then begin
		;read in data
		openr, in_lun, file_name, /swap_endian, /get_lun   ;we need to swap the endian here
		readu, in_lun, tile_data
		free_lun, in_lun
	endif

	return, tile_data

End

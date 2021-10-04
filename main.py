import json,requests
from arcgis.gis import GIS
from pathlib import Path

try:
    with open ('./credentials.json') as creds:
        credentials = json.load(creds)

except FileNotFoundError:
    # credentials file stored in different location on home vs work computer
    # with open ('/media/mike/OS/Users/fullerm/source/repos/autotimeclock/credentials.json') as creds:
    with open ('~/Documents/repos/afdc/credentials.json') as creds:
        credentials = json.load(creds)

# api_key = credentials['api_key']
ago_user = credentials['ago_user']
ago_pw = credentials['ago_pw']
# chrome_driver_loc = credentials['chrome_driver_loc']

# key: ["title","url_parameters","snippet"]
tarta_dict = {
    "routes":["Routes",""],
    "stops":["Stops",""]
    
}
# api_url_base =f"https://developer.nrel.gov/api/alt-fuel-stations/v1.geojson?api_key={api_key}&fuel_type=ELEC&state=OH,MI"

gis = GIS(username=ago_user, password=ago_pw)
item_properties_dict = {}
for key in tarta_dict:


    item_properties_dict = {

        "type":"GeoJson",
        "dataURL":"",
        "filename":"",
        "typeKeywords":"",
        
        "title":f"TARTA {tarta_dict[key][0]}",
        "url":"",
        "tags":["TARTA","transit"],
        "snippet":f"Most recent TARTA {tarta_dict[key][0]} from TARTA's GTFS feed updated daily.",
        "access":"public"
        

    }
    print(f"{Path.cwd()}/tarta_{key}.geojson")

    try:
        item = gis.content.add(
            item_properties=item_properties_dict,
            data=f"{Path.cwd()}/tarta_{key}.geojson",
            folder=""
            )
    except: 
        results = gis.content.search(f"tarta_{key}.geojson", item_type = 'GeoJson')
        if len(results) != 1:
            print("Multiple results!")
            print(results)
        else:
            print(f'Item delete status: {results[0].can_delete}')
            if results[0].can_delete == False:
                print('Cannot delete!')
            else:
                print(f'Deleting {results[0]}...')
                results[0].delete()
                print('Done')
    print("Uploading...")
    new_item = gis.content.add(
        item_properties=item_properties_dict,
        data=f"{Path.cwd()}/tarta_{key}.geojson",
        folder=""
    )
    print('Done.')
    print('Attempting to publish...')
    new_item.publish(file_type='geojson', overwrite=True)
    print('Done.')
    print('Sharing hosted feature layer with everyone...')
    hosted_item=gis.content.search(
        f"title:TARTA {tarta_dict[key][0]}",
        item_type = 'Feature Service')[0]
    print(hosted_item)
    hosted_item.share(everyone=True)
    print('Done.')
    # item.publish(file_type='geojson')





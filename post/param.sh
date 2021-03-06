#!/bin/bash
# FileName: post/param.sh
#
# Author: rachpt@126.com
# Version: 2.2v
# Date: 2018-06-19
#
#-------------settings---------------#

#-------------------------------------#
function from_desc_get_prarm()
{
    #---test name,avoid special characters in name---#
    plain_name_tmp="$(echo "$TR_TORRENT_NAME"|sed "s/‘/\'/g;s/“/\"/g;s/。/./g;s/，/,/g;s/：/:/g;s/；/;/g;s/！/!/g")"
    if [ "$plain_name_tmp" != "$TR_TORRENT_NAME" ]; then
        mv "${flexget_path}/${new_torrent_name}.torrent" "${flexget_path}/${plain_name_tmp}.torrent"
        torrentPath="${flexget_path}/${plain_name_tmp}.torrent"
        new_torrent_name="$plain_name_tmp"
        TR_TORRENT_NAME="$plain_name_tmp"
        plain_name_tmp=''
    fi
    #---name---#
    no_dot_name=`echo "$new_torrent_name"|sed 's/\./ /g'|sed "s/DD2 0/DD2.0/g;s/H 26/H.26/g;s/5 1/5.1/g;s/7 1/7.1/g;s/\(.*\) mp4/\1/g;s/\(.*\) mkv/\1/g"`
    dot_name=`echo "$new_torrent_name"|sed "s/[ ]\+/./g;s/\(.*\)\.mp4/\1/g;s/\(.*\)\.mkv/\1/g"`
    #---get torrent's type---#

    #---hudbt & whu---#
    if [ "`egrep '[国地产][　 ]*[家区地][　 ]*中国大陆|[国地产][　 ]*[家区地][　 ]*中国' "$source_detail_desc"`" ]; then
        whu_selectType='401'
        hudbt_selectType='401'
    elif [ "`egrep '[国地产][　 ]*[家区地][　 ]*马来西亚|[国地产][　 ]*[家区地][　 ]*日本|[国地产][　 ]*[家区地][　 ]*韩国|[国地产][　 ]*[家区地][　 ]*印度|[国地产][　 ]*[家区地][　 ]*泰国|[国地产][　 ]*[家区地][　 ]*伊朗' "$source_detail_desc"`" ]; then
        whu_selectType='414'
        hudbt_selectType='414'
    elif [ "`egrep '[国地产][　 ]*[家区地][　 ]*中国台湾|[国地产][　 ]*[家区地][　 ]*台湾|[国地产][　 ]*[家区地][　 ]*香港|[国地产][　 ]*[家区地][　 ]*中国香港|[国地产][　 ]*[家区地][　 ]*澳门' "$source_detail_desc"`" ]; then
        whu_selectType='413'
        hudbt_selectType='413'
    fi
    if [ -z "$whu_selectType" ]; then
        whu_selectType="$default_select_type_whu"
    fi

    #---hudbt & whu ipad---#
    case "$new_torrent_name" in
        *[Ii][Pp][Aa][Dd]*|*iHD*)
            hudbt_selectType='430'
            whu_standardSel='9'
            case "$new_torrent_name" in
                *720[Pp]*)
                    hudbt_standardSel='3' ;;
               	*1080[Pp]*)
                   	hudbt_standardSel='1' ;;
               	*)
               	    hudbt_standardSel="$default_standard_hudbt" ;;
            esac
            ;;
        *)
            if [ -z "$hudbt_selectType" ]; then
                hudbt_selectType="$default_select_type_hudbt"
            fi
            case "$new_torrent_name" in
                *720[Pp]*)
                    hudbt_standardSel='3'
               	    whu_standardSel='3'
               	    ;;
               	*1080[Pp]*)
                   	hudbt_standardSel='1'
               	    whu_standardSel='1'
               	    ;;
               	*)
               	    hudbt_standardSel="$default_standard_hudbt"
               	    whu_standardSel="$default_standard_whu"
               	    ;;
            esac
            ;;
    esac
	#---纪录片---#
	if [ "`egrep '类[　 ]*别[　 ]*纪录片' "$source_detail_desc"`" ]; then
        nanyangpt_selectType='406'
        npupt_selectType='404'
        hudbt_selectType='404'
        whu_selectType='404'
        byrbt_selectType='410'
        # other site
    else
        nanyangpt_selectType="$default_select_type_nanyangpt"
        npupt_selectType="$default_select_type_npupt"
        byrbt_selectType="$default_select_type_byrbt"
    fi

    #---npupt source---#
    npupt_select_source=''
    second_type_byrbt=''
    if [ "`egrep '[国地产][　 ]*[家区地][　 ]*大陆|[国地产][　 ]*[家区地][　 ]*中国|[国地产][　 ]*[家区地][　 ]*台湾|[国地产][　 ]*[家区地][　 ]*香港' "$source_detail_desc"`" ]; then
        npupt_select_source='6'
        second_type_byrbt='11'
    elif [ "`egrep '[国地产][　 ]*[家区地][　 ]*日本|[国地产][　 ]*[家区地][　 ]*韩国' "$source_detail_desc"`" ]; then
        npupt_select_source='4'
        second_type_byrbt='14'
    elif [ "`egrep '[国地产][　 ]*[家区地][　 ]*美国|[国地产][　 ]*[家区地][　 ]*英国|[国地产][　 ]*[家区地][　 ]*加拿大' "$source_detail_desc"`" ]; then
        npupt_select_source='5'
    fi
    if [ -z "$npupt_select_source" ]; then
        npupt_select_source="$default_standard_npupt" #7
    fi

    #---byr second_type---#
    if [ "`egrep '[国地产][　 ]*[家区地][　 ]*美国|[国地产][　 ]*[家区地][　 ]*加拿大|[国地产][　 ]*[家区地][　 ]*墨西哥' "$source_detail_desc"`" ]; then
        second_type_byrbt='13'
    elif [ "`egrep '[国地产][　 ]*[家区地][　 ]*法国|[国地产][　 ]*[家区地][　 ]*英国|[国地产][　 ]*[家区地][　 ]*德国|[国地产][　 ]*[家区地][　 ]*俄罗斯|[国地产][　 ]*[家区地][　 ]*丹麦|[国地产][　 ]*[家区地][　 ]*瑞士|[国地产][　 ]*[家区地][　 ]*西班牙|[国地产][　 ]*[家区地][　 ]*葡萄牙' "$source_detail_desc"`" ]; then
        second_type_byrbt='12'
    fi
    if [ -z "$second_type_byrbt" ]; then
        second_type_byrbt="$default_second_type_byrbt" #1
    fi

    #---imdb---#
    if [ -z "$imdbUrl" ]; then
        imdbUrl="$default_imdb_url"
    fi

    #---subtitle---#
    if [ "`egrep '国[　 ]+家[　 ]+中国大陆[ ]*$|国[　 ]+家[　 ]+中[　 ]*国[ ]*$' $source_detail_desc`" ]; then
        smallDescr="`echo "$subname_2"` $subname_chs_include"
        smallDescr_byrbt="$subname_2"
    else
        if [ "$subname_1" != "`echo "$subname_1"|egrep -o '[a-zA-Z ]+'`" ]; then
             smallDescr="`echo "$subname_1"` $subname_chs_include"
             smallDescr_byrbt="$subname_1"
        elif [ "$subname_2" ]; then
             smallDescr="`echo "$subname_2"` $subname_chs_include"
             smallDescr_byrbt="$subname_2"
        else
            smallDescr="$default_subname"
            smallDescr_byrbt="$default_subname"
        fi
    fi

    #---join desc---#
    if [ -s "$source_detail_desc" ]; then
        simple_des="${descrCom_simple}
        `cat "$source_detail_desc"`"

        complex_des="${descrCom_complex}
        `cat "$source_detail_desc"`"

    else
        simple_des="${descrCom_simple}
        $failed_to_get_des"

        complex_des="${descrCom_complex}
        $failed_to_get_des"
    fi
        nanyangpt_des="$simple_des"
        npupt_des="$simple_des"
#        hudbt_des="$complex_des"
#        whu_des="$complex_des"
}
#-------------------------------#
from_desc_get_prarm

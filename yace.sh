#!/bin/sh

# 命令执行参数
#
# sh jmeterShellPath -n -t score_select.jmx -l score_select.jtl
#

# 功能需求
# 1. 根据输入的命令来增加压测任务


# 已知问题
# 1. zip压缩后不在当前目录




jmeterShellPath=$1
jmxFile=$2

while true
do
    if [ ! ${jmeterShellPath} ]
    then
        echo '请输入JMeter路径'
        continue
    fi

    if [ ! ${jmxFile} ]
    then
        echo '请输入JMX文件路径'
        continue
    fi


    break
done
#echo $a

# 文件名zlr
jtlFile=${jmxFile%.*}

# 线程组设置



# 重置所有 线程组到1
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">1/g" $jmxFile

# 开始运行
# sed -i 's/"ThreadGroup.num_threads">1/"ThreadGroup.num_threads">100/g' $a
# sh jmeterShellPath -n -t $a -l ${b}_100_1.jtl
# sed -i 's/"ThreadGroup.num_threads">100/"ThreadGroup.num_threads">500/g' $a
# sh jmeterShellPath -n -t $a -l ${b}_500_1.jtl



# sed 找到目标位置修改
# 为了正常找到"", 需要对其进行转义
# LEN=${#NUM_THREADS[@]}

while true
do

   # 让使用者选择所需要登陆服务器的所属序号
    read -p '请输入要设置的线程组数量: ' NUM_THREADS

    # 如果输入为空格或者回车，显示错误信息，后续代码不再执行，重新循环。
    if [ ! ${NUM_THREADS} ]
    then
        echo '请输入序号'
        continue
    fi

    # 如果输入的不是数字，显示错误信息，后续代码不再执行，重新循环。
    if [[ "${NUM_THREADS}" =~ [^0-9]+ ]]
    then
        echo '序号是数字'
        continue
    fi

    # 如果输入的以 0 开头的数字、大于等于服务器台数、小于 0，显示错误信息，后续代码不再执行，重新循环。
    # if [[ "${NUM_THREADS}" =~ ^0[0-9]+ ]] || [ ${NUM_THREADS} -ge ${LEN} ] || [ ${NUM_THREADS} -lt 0 ]
    if [[ "${NUM_THREADS}" =~ ^0[0-9]+ ]] || [ ${NUM_THREADS} -lt 0 ]
    then
        echo '请输入存在的序号'
        continue
    fi

    # 跳出循环
    break

done

screen_echo() {

printf "%-7s" '线程组数量为'　
printf "\e[31m %-5s\e[0m\n" "$NUM_THREADS" # 颜色为红色


# for((i=0; i <$LEN; i++))
# do
#     printf "\e[31m %-5s\e[0m|" "$i" # 颜色为红色
#     printf "%-15s\n |" "${NUM_THREADS[$i]}"  # 显示线程组数量
# done

}


# 调用函数，让信息显示出来
screen_echo



auto_stress_test() {
    jtlFileName=${jtlFile}_${NUM_THREADS}_1.jtl
    sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">$NUM_THREADS/g" $jmxFile
    sh $jmeterShellPath -n -t $jmxFile -l $jtlFileName
    zip ${jtlFileName}.zip ${jtlFileName}
}


auto_stress_test


# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[1]}/g" $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[1]}_1.jtl
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[2]}/g" $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[2]}_1.jtl
# sed -i "s/\"ThreadGroup.num_threads\">[0-9]*/\"ThreadGroup.num_threads\">${num_threads[3]}/g" $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[3]}_1.jtl

# # 设置循环次数

# # 控制器  不需要改
# sed -i 's/"LoopController.loops">1/"LoopController.loops">-1/g' $jmxFile

# # 控制器 不需要改
# sed -i 's/"ThreadGroup.scheduler">false/"ThreadGroup.scheduler">true/g' $jmxFile

# # 时间: 3分钟
# sed -i 's/"ThreadGroup.duration">/"ThreadGroup.duration">180/g' $jmxFile

# # 并发数 修改回1000
# sed -i 's/"ThreadGroup.num_threads">5000/"ThreadGroup.num_threads">1000/g' $jmxFile

# # sh jmeterShellPath -n -t $a -l ${b}_100_3min.jtl
# # sed -i 's/"ThreadGroup.num_threads">100/"ThreadGroup.num_threads">500/g' $a
# # sh jmeterShellPath -n -t $a -l ${b}_500_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">1000/"ThreadGroup.num_threads">1000/g' $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[1]}_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">1000/"ThreadGroup.num_threads">3000/g' $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[2]}_3min.jtl
# sed -i 's/"ThreadGroup.num_threads">3000/"ThreadGroup.num_threads">5000/g' $jmxFile
# sh jmeterShellPath -n -t $jmxFile -l ${jtlFile}_${num_threads[3]}_3min.jtl

# # 还原到原先状态
# sed -i 's/"LoopController.loops">-1/"LoopController.loops">1/g' $jmxFile
# sed -i 's/"ThreadGroup.scheduler>"true/"ThreadGroup.scheduler">false/g' $jmxFile
# sed -i 's/"ThreadGroup.duration">180/"ThreadGroup.duration">/g' $jmxFile
# sed -i 's/"ThreadGroup.num_threads">5000/"ThreadGroup.num_threads">1/g' $jmxFile


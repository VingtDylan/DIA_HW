[toc]

# <center> 基于MeanShift的目标跟踪</center>

## MeanShift跟踪流程

* 在当前帧，计算候选目标的特征（候选块的颜色直方图）

* 计算候选目标与初始目标的相似度：$\hat{\rho}(y_0) = \sum_{u = 1} ^ m \sqrt{\hat{p}_u(y_0)\hat{q}_u}$

* 计算权值$\{w\}_{i = 1, 2,3,...,m}$

* 利用MeanShift算法，计算目标新位置：
  $$
y_1 = \frac{\sum_{i = 1} ^ {n_h} x_iw_i g(||\frac{y_0-x_i}{h}||^2)}{\sum_{i = 1} ^ {n_h} w_i g(||\frac{y_0-x_i}{h}||^2)}
  $$

* 若$||y_1-y_0|| < \varepsilon$,则停止，否则$y_0\leftarrow y_1$转3

  限制条件：新目标中心需位于原目标中心附近。

## 实验效果

以Lemming样本为例

| ![](C:images\2.jpg) | ![](C:images\3.jpg) | ![](C:images\4.jpg) | ![](C:images\5.jpg) | ![](C:images\6.jpg) |![](C:images\7.jpg) |
| ---- | ---- | ---- | ---- | ---- | ---- |
| ![](C:images\24.jpg) |![](C:images\25.jpg) | ![](C:images\26.jpg) | ![](C:images\27.jpg) | ![](C:images\28.jpg) | ![](C:images\29.jpg) |
| ![](C:images\46.jpg) |![](C:images\47.jpg) | ![](C:images\48.jpg) | ![](C:images\49.jpg) | ![](C:images\50.jpg) | ![](C:images\51.jpg) |
| ![](C:images\68.jpg) |![](C:images\69.jpg) | ![](C:images\70.jpg) | ![](C:images\71.jpg) | ![](C:images\72.jpg) | ![](C:images\73.jpg) |
| ![](C:images\90.jpg) |![](C:images\91.jpg) | ![](C:images\92.jpg) | ![](C:images\93.jpg) | ![](C:images\94.jpg) | ![](C:images\95.jpg) |
|...|...|...|... |...| ...|
| ![](C:images\390.jpg) |![](C:images\391.jpg) | ![](C:images\392.jpg) | ![](C:images\393.jpg) | ![](C:images\394.jpg) | ![](C:images\395.jpg) |



## 问题分析

### 出现的失败情况

* 目标漂移

* 目标丢失

### 可能的原因

* 遮挡物的影响
* 光照亮度变化(woman样本较为严重)

### 解决方案

* 在woman样本中，光照亮度变化较为明显，而RGB颜色空间对光照亮度的变化是比较敏感的，因此，使用RGB颜色空间进行目标跟踪是不利的。而HSV颜色空间是根据颜色的直观属性，即色调，饱和度，亮度，创建的一种颜色空间，因此将有利于目标的追踪。

  <center>
     <img style="border-radius: 0.3125em;
     box-shadow: 0 2px 4px 0 rgba(34,36,38,.12),0 2px 10px 0 rgba(34,36,38,.08);" 
     src="images\1.png">
     <br>
     <div style="color:orange; border-bottom: 1px solid #d9d9d9;
     display: inline-block;
     color: #999;
     padding: 2px;">实验原理参考</div>
  </center>

* 调节通道的权值，例如在HSV颜色空间模型下，h通道的权重可以设置在25-30左右。

* 目标跟踪的box是固定的，可以通过二阶矩对目标大小变化做适应性调整。


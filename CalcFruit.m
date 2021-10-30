function [sum, percent] = CalcFruit(imgPixel, MaskPixel, ImageNum)
    if ((imgPixel==0)||(MaskPixel==0)||(MaskPixel>imgPixel))
        sum = false;
        percent = 0;
    else
        percent = (MaskPixel * 100)/imgPixel;
        
        switch ImageNum
            case 1
                if(percent >= 80)
                    sum = true;
                else
                    sum = false;
                end
            case 2
                if(percent >= 75)
                    sum = true;
                else
                    sum = false;
                end
            case 3
                if(percent >= 90)
                    sum = true;
                else
                    sum = false;
                end
            case 4
                if(percent >= 75)
                    sum = true;
                else
                    sum = false;
                end
             case 5
                if(percent >= 85)
                    sum = true;
                else
                    sum = false;
                end
            case 6
                if(percent >= 70)
                    sum = true;
                else
                    sum = false;
                end
            case 7
                if(percent >= 85)
                    sum = true;
                else
                    sum = false;
                end
            case 8
                if(percent >= 65)
                    sum = true;
                else
                    sum = false;
                end
            case 9
                if(percent >= 30)
                    sum = true;
                else
                    sum = false;
                end
            case 10
                if(percent >= 70)
                    sum = true;
                else
                    sum = false;
                end
 
        end
    end
end


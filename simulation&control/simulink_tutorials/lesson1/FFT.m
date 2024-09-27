function [Fre,Amp,Ph] = FFT(data,Fs,ampDB,isDetrend)
    % ���ٸ���Ҷ�任
    % data:��������
    % Fs:������
    % ampDB:�߼�ֵ���Ƿ���ж����任��Ĭ��Ϊfalse
    % isDetrend:�߼�ֵ���Ƿ����ȥ��ֵ����Ĭ��Ϊtrue
    % ����[Fre:Ƶ��,Amp:��ֵ,Ph:��λ�����ȣ�]
    if nargin<3
        ampDB=false;
        isDetrend=true;
    elseif nargin<4
        isDetrend=true;
    end
    n=length(data);
    if mod(n,2)==1
        n=n-1;
        data=data(1:n);
    end
    if isDetrend
        data=detrend(data);
    end
    Y = fft(data);
    %Ƶ��
    Fre=(0:n-1)*Fs/n;
    Fre=Fre(1:n/2);
    %��ֵ
    Amp=abs(Y(1:n/2));
    Amp([1,n/2])=Amp([1,n/2])/n;
    Amp(2:n/2-1)=Amp(2:n/2-1)/(n/2);
    if ampDB
        Amp=20*log(Amp);
        Amp(Amp<0)=0;
    end
    %��λ
    Ph=angle(Y(1:n/2));
end